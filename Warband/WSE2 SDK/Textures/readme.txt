WSE2 textures
=============

Two textures live here, and neither of them is a dependency. The engine generates both at
startup, so a module that ships nothing still gets the feature; what is here is the
generated article itself, byte for byte, to paint over. An example that differed from the
default would be worse than none - you would paint against one thing and get another.

Both are found the same way: your module's Textures folder first, then the common Warband
Textures folder, then the generated one. Nothing has to be declared in a .brf, nothing in
the shader changes, and the log says which file was taken.


Blood splash atlas
==================

wse2_blood_splats.dds is the atlas WSE2 projects onto a wounded agent when
bShaderBloodStains is on. It is here as a starting point to paint over, not as
a file the game needs: if nothing is found the engine generates this same
atlas at startup, so a module that ships nothing still gets decals.

Replacing it
------------

Drop your own wse2_blood_splats.dds into your module's Textures folder:

    Modules/<your module>/Textures/wse2_blood_splats.dds

That wins over everything else. A copy in the common Warband Textures folder
replaces it for every module instead. Nothing has to be declared in a .brf and
nothing in the shader changes - the engine looks the file up by name at device
restore, and the log line BLOOD atlas file= says which one it took.

The contract
------------

* Four by four tiles, read left to right and top to bottom. The engine picks
  one of the sixteen at random per hit.

* THE TILE'S +X IS THE WAY THE BLOW TRAVELLED. The decal is turned by the blow
  and stretched along it, so paint each splash leaning to the RIGHT: a torn head
  on the left, the fingers and the satellites thrown to the right. The generated
  one is drawn that way - a ragged head, two to four tapering spines with the
  drop that broke off each tip, and small satellites following them, smaller the
  further they went. A splash painted symmetrically still works, it simply says
  nothing about where the blow came from.

* Any square size. 512 is what the generated one uses, which is 128 pixels a
  tile - more than a stain ever covers on screen.

* ONLY THE ALPHA IS READ. The colour of blood comes from the skin
  (m_bloodColor on the skin, or on the horse's item), so a module whose
  creatures bleed something other than red sets it there and it works with any
  atlas. Painting colour into the RGB of this file does nothing.

* EVERY TILE NEEDS A TRANSPARENT BORDER. A decal is cut to its own tile by
  clamping the lookup, so a splash painted to the very edge of its tile will
  smear along the edge instead of ending, and can show up as a line across the
  neighbouring one. Leave a few pixels of nothing all the way round.

* Uncompressed is recommended over DXT. The alpha is the whole content here and
  block compression quantises exactly that, which shows as steps in the rim of
  every droplet.

* Mipmaps are optional and the file here has none. The engine asks for four
  levels when it loads the atlas and filters them down itself, so a single
  level is enough to paint. They are not optional for the look, though: a decal
  reaches fifty metres, where a tile covers a handful of screen pixels, and
  without a chain the droplets crawl as the camera moves. Four levels is a cap
  rather than a full chain on purpose - a box filter over a hard edged mask
  thins the small droplets away first.

wse2_blood_splats_preview.png shows the layout with the tile grid drawn on it.
It is documentation only - the game never reads it.

What a decal does with the tile
-------------------------------

The tile is projected onto the skin at the point the blow landed, in the
skeleton's rest pose, so it stays on the elbow it hit while the body moves and
it does not change when the level of detail does. It is turned to face the way
the blow travelled and stretched along it, so a cut from the side leaves a mark
running across the body rather than a round one. Four at a time per piece of
clothing; a fifth hit pushes the oldest out, and hits landing close together
strengthen the mark already there instead of taking a slot.


Foam tile
=========

wse2_foam.dds is the tile WSE2 lays along the water's edge when bWaterFoam is on. If it is
missing the engine generates this same tile at startup, and the log line FOAM tile file=
says which one it took.

The contract
------------

* ONLY THE ALPHA IS READ. Foam is water full of air: it scatters back whatever light falls
  on it rather than having a colour, so the shader takes the colour from the sun, the sky
  and the ambient of the scene and uses this file for coverage alone. Painting colour into
  the RGB does nothing.

* IT HAS TO TILE. Seams show: the band runs for the whole length of a shoreline. The
  generated one wraps by construction - its value noise is built on a lattice read modulo
  its own period - so if you paint your own, make it wrap.

* The two axes are not alike, and this is the part worth reading twice. ACROSS the texture
  (V) is the band itself: V runs from the water's edge at zero to the depth where the surf
  ends at one, so whatever you paint down the V axis is the profile of the surf and it is
  laid over the band exactly once however wide the band is set. ALONG the texture (U) is
  distance over the water, tiling about every nine metres.

  So a strip painted with foam at the top of V and nothing at the bottom gives a line of
  surf at the shore. A texture painted as an even scatter, like the generated one, gives
  foam spread through the band. Both work; a texture drawn as a one-way ribbon, as the
  stock foam.dds is, does not - that one is made to be laid along a coastline by hand, and
  here it arrives with its grain across the water instead.

* Any square size. 256 is what the generated one uses.

* Uncompressed is recommended over DXT for the same reason as the blood atlas: the alpha
  is the whole content and block compression quantises exactly that.

* Mipmaps are optional and this file has none. The engine asks for a full chain when it
  loads the tile and filters it down itself. They are not optional for the look though -
  the band reaches the horizon, and without a chain it crawls.

wse2_foam_preview.png shows the alpha as a greyscale image. It is documentation only.

What the engine does with it
----------------------------

Where there is foam at all is not in this file. The engine measures that when it builds a
scene: how near the shore the water is, whether the body it belongs to is open water rather
than a puddle, and how gently the bottom shelves - surf needs a run-up, so a bank that
drops away gets none. Then the band itself is drawn per pixel from the depth of water in
front of it, which is what keeps it off hulls, posts and reeds standing in the water, and
it rides up and down with the swell.

The settings are bWaterFoam, fWaterFoamStrength, fWaterFoamDepth, fWaterFoamWidth and
fWaterFoamMaxSlope; config_template.txt describes each.
