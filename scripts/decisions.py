#!/usr/bin/env python3
"""Reads a project's DECISIONS.md and says, in plain words, what needs attention.

  python3 decisions.py DECISIONS.md            what is waiting on the owner, and for how long; hygiene problems
  python3 decisions.py DECISIONS.md --branches also compare IDs across remote branches (finds collisions)
  python3 decisions.py DECISIONS.md --summary  a one-page owner summary (newest 20 decisions, plain words)

It reads any markdown table whose rows start with a decision ID (D-12, D-B3-04, P-07). Columns are found by their
header names, so both the playbook's index layout and older, wider logs work. It never edits anything.
Exit code 1 if there are duplicate IDs or collisions, so it can gate a close.
"""
import datetime, re, subprocess, sys
from collections import Counter, defaultdict

ID = re.compile(r'^(?:D|P)-[A-Za-z0-9.]+(?:-[A-Za-z0-9.]+)*$')
DATE = re.compile(r'(\d{1,2})\s+([A-Z][a-z]{2})[a-z]*\.?(?:\s+(\d{4}))?|(\d{4})-(\d{2})-(\d{2})')
MONTHS = {m: i for i, m in enumerate('Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec'.split(), 1)}


def cells(line):
    return [c.strip() for c in re.split(r'(?<!\\)\|', line.strip().strip('|'))]


def parse(text):
    rows, header, previous = [], None, None
    for line in text.splitlines():
        if not line.lstrip().startswith('|'):
            header, previous = None, None
            continue
        c = cells(line)
        if all(re.fullmatch(r':?-{2,}:?', x) for x in c if x):
            # A separator row: the row just before it is the header of this table.
            if previous is not None:
                header = [x.lower() for x in previous]
            continue
        previous = c
        first = c[0].replace('*', '').replace('`', '').strip()
        if header and ID.match(first):
            rows.append({'id': first, 'cells': c, 'header': header})
    return rows


def col(row, *names):
    for h, v in zip(row['header'], row['cells']):
        if any(n in h for n in names):
            return v
    return ''


def when(text, today):
    m = DATE.search(text or '')
    if not m:
        return None
    try:
        if m.group(4):
            return datetime.date(int(m.group(4)), int(m.group(5)), int(m.group(6)))
        year = int(m.group(3)) if m.group(3) else today.year
        d = datetime.date(year, MONTHS[m.group(2)], int(m.group(1)))
        return d if d <= today or m.group(3) else d.replace(year=year - 1)
    except (KeyError, ValueError):
        return None


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    flags = {a for a in sys.argv[1:] if a.startswith('--')}
    path = args[0] if args else 'DECISIONS.md'
    try:
        text = open(path, encoding='utf-8').read()
    except OSError:
        print(f'No decision log at {path}.')
        return 0
    today = datetime.date.today()
    rows = parse(text)
    ids = [r['id'] for r in rows]
    problems = 0

    if '--summary' in flags:
        print(f'# Decisions: the newest {min(20, len(rows))} of {len(rows)}\n')
        for r in rows[-20:]:
            q = col(r, 'question') or col(r, 'source')
            a = col(r, 'answer')
            print(f"- **{q[:110]}** → {a[:110]}  ({col(r, 'date')}, {r['id']})")
        return 0

    pending = [r for r in rows if 'pending' in col(r, 'status').lower()]
    settled_elsewhere = set()
    for r in rows:
        link = col(r, 'replaces', 'settled', 'supersed') + ' ' + col(r, 'source')
        for m in re.finditer(r'(?:settles|replaces|supersedes|confirm(?:s|ed by)?)\s+((?:D|P)-[A-Za-z0-9.]+(?:-[A-Za-z0-9.]+)*)', link, re.I):
            settled_elsewhere.add(m.group(1))

    print(f'{len(rows)} decisions in {path}.')
    print(f'\n## Waiting on the owner: {len(pending)}')
    aged = []
    for r in pending:
        d = when(col(r, 'date'), today)
        aged.append(((today - d).days if d else -1, r))
    for days, r in sorted(aged, key=lambda x: -x[0]):
        age = f'{days} days' if days >= 0 else 'age unknown'
        own = re.search(r'(?:confirmed|settled|replaced|superseded) by ((?:D|P)-[A-Za-z0-9.]+(?:-[A-Za-z0-9.]+)*)', col(r, 'status'), re.I)
        note = ('  ← a later row settles this: update its status'
                if r['id'] in settled_elsewhere or own else '')
        over = '  ← over 7 days: ask, or close "by profile"' if days > 7 and not note else ''
        q = (col(r, 'question', 'decision', 'what') or col(r, 'source'))[:90]
        print(f"- {r['id']} ({age}): {q}{note}{over}")

    dupes = [i for i, n in Counter(ids).items() if n > 1]
    if dupes:
        problems += 1
        print(f"\n## The same ID used twice in this file: {', '.join(dupes)}")

    numeric = [(i, int(i[2:])) for i in ids if re.fullmatch(r'D-\d+', i)]
    backwards = sum(1 for a, b in zip(numeric, numeric[1:]) if b[1] < a[1])
    if backwards:
        print(f'\n## Out of order: the numbering goes backwards in {backwards} place(s). Keep the file in ID order.')

    long_rows = sum(1 for r in rows if len(' '.join(r['cells'])) > 600)
    if long_rows:
        print(f'\n## {long_rows} rows are over 600 characters. Move options and build notes to work/<build>/NOTES.md.')
    size = len(text.encode())
    if size > 100_000:
        print(f'\n## The file is {size // 1000} KB. Over about 100 KB nobody can read it: run /playbook:tidy decisions.')

    if '--branches' in flags:
        seen = defaultdict(dict)
        try:
            refs = subprocess.run(['git', 'for-each-ref', '--format=%(refname:short)', 'refs/remotes'],
                                  capture_output=True, text=True, check=True).stdout.split()
        except (OSError, subprocess.CalledProcessError):
            refs = []
        for ref in refs:
            if ref.endswith('/HEAD'):
                continue
            out = subprocess.run(['git', 'show', f'{ref}:{path}'], capture_output=True, text=True)
            if out.returncode:
                continue
            for r in parse(out.stdout):
                seen[r['id']][ref] = (col(r, 'question') or col(r, 'source') or ' '.join(r['cells'][1:3]))[:60]
        clashes = {i: b for i, b in seen.items() if len(set(b.values())) > 1}
        print(f'\n## Across {len(refs)} remote branches: {len(clashes)} ID(s) mean different things on different branches')
        for i, b in sorted(clashes.items())[:30]:
            problems += 1
            print(f'- {i}: ' + ' | '.join(f'{ref}: "{txt}"' for ref, txt in list(b.items())[:3]))

    return 1 if problems else 0


if __name__ == '__main__':
    try:
        sys.exit(main())
    except BrokenPipeError:
        sys.exit(0)
