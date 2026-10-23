# Running-App: the final family review (23 Oct 2026)

Six panellists looked at every locked piece together at real size, light and dark (`board.py` family rows and the
widget states): IL (illustrator), AD (art director), CX (colour and accessibility), PE (vector production), the
arborist and the widget/app designer. Every verdict: "one family, ready to lock after a few fixes". Most out of
family, by reviewer: the dark plane (CX), the body map (AD), the plane's pen (IL), the street tree's stretch (PE,
arborist), the dark ink widget (widget designer).

## Points, merged (who raised them; ⚠ = clashes with a decision Ben made)
**Colour**
1. Plane, dark: warm khaki bark greys; use the door's cool spot greys (CX, AD, IL, widget).
2. One jacaranda outline: the spot/widget dark outline #A99BE0 is 2.9:1 over the back shade (rule 4); use #958DD6.
   In light the street uses #6A64A2, the others #4E4879; pick one (CX, AD).
3. Body map lilac: the see-through tint lands off the ramp (#B6B1CD / #7B789E); fill chosen sites solid from the
   ramp and add a non-colour cue (a 0.5 pt ring). App-side, `CheckInParts.swift` (CX, AD, widget).
4. Tokens: the `widget` block doesn't match the final widget SVGs; add the back-mass steps to the ramp (CX, PE).

**Line**
5. Body map: dark outline 3.58:1 over the shade (use #6C6862); silhouette 0.67 pt, raise to 1.0 (IL, CX).
6. Plane: an even closed outline; open and taper the top contour, one lit-side break (IL).
7. Jacaranda: every clump fully closed; open the top-left 30–40% of upper clumps (IL). Re-exports three pieces.
8. Door at 84 pt: drop the finials and lace scallops (IL).

**Ground and states**
9. ⚠ Street tree stretched 1.1 × 1.65 (crown 1.5× taller than widget/spot; vertical lines thinner): use even scale
   (PE, arborist). Ben picked "today's footprint" (A) over even scale (B) on 23 Oct.
10. ⚠ Widget ink state: outline only and no ground; reads as a wireframe in dark (widget, AD, arborist). Designed
   that way: "ink + paper only, the path arrives with the colour".
11. Street, dark: the front-garden shrubs are near-black like the windows; lift one step (arborist).
12. Widget bloom: fallen blossom spreads 45% of a crown left of the crown; keep it within ~1.2× the spread (arborist).

**Production**
13. Paper-coloured cut-outs (launch mark plane, widget ink) instead of real holes: they show as patches on tinted
   icons, accent widgets and StandBy; cut even-odd holes (PE).
14. Frames: the widget's non-integer viewBox (use `-1 22 190 132`), its ground clipped by 2 units, the mark's
   1.08× group baked into `0 0 96 96` (PE, IL).
15. Ground recipes: the body map's shadow is lilac-tinted #3C3050 and the door's dark file has an extra ink line;
   move both to the jacaranda ground tokens (PE).
16. ⚠-ish Launch mark ring swells to 3.9 pt, over the 1.25 cap: write a logo exemption into the style sheet rather
   than thin it (PE, widget).

## Ben's calls (23 Oct)
- **Agreed:** 1, 2, 3 (app-side, with the ship PR), 4, 5, 6, 11, 12, 13, 14, 15, 16.
- **Rejected:** 7 (open the tree clumps), 8 (simpler door), 9 (unstretch the street tree), 10 (fill the ink widget).

Applied as: `street/r10c` + `widget-jacaranda/final2` + `spot-jacaranda/s3` (the jacaranda colours, tokens, shrubs,
blossom, widget holes and frame), `spots/p4a` + `spots/d4a` (plane greys and outline, door ground), `body-map/m4b`
(line and ground), `launch-mark/l3` (real holes, baked frame), and a logo exemption in `COHERENCE.md`.

## Locked (Ben, 23 Oct)
The family is locked as one set: street `r10c`, widget `widget-jacaranda/final2`, spot jacaranda `s3`, launch mark
`l3`, body map `m4b`, door `d4a`, plane `p4a`. 44 final vectors checked: valid, integer viewBoxes, no gradients,
token colours only, within size. Known and accepted: the light street canopy reads a little heavier; the dark
shrubs and the dark door ground are subtle; the widget's ink line is still its own #55524D. Shipping: one PR to
main when Ben asks (the body map's solid lilac sites and the `LaunchLap.swift` numbers go with it).
