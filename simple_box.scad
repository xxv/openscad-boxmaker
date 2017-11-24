include <boxmaker.scad>;

// Inner Dimensions: Length (mm)
x = 100;
// Inner Dimensions: Width (mm)
y = 70;
// Inner Dimensions: Height (mm)
z = 50;

// Material thickness (mm)
thickness = 3;

// Lid?
lid = 1; // [0:Closed box,1:Box with lid]

// Render type
show_3d = 0; // [0:2D for cutting,1:3D preview]

/////////////////////////////////////////////////////////////////////
/* [Hidden] */

box_inner = [x, y, z];

// Tab width (mm)
tab_width = thickness * 2;

  // Tab width (X, Y, Z, TopX, TopY) (mm)
tabs = [tab_width, tab_width, tab_width, tab_width, tab_width];

// Tab width (X, Y, Z, TopX, TopY) (mm)
tabs_with_lid = [tab_width, tab_width, tab_width, box_inner[0]/3, box_inner[1]/3];


if (show_3d) {
  if (lid) {
    box_3d(box_inner, thickness, tabs_with_lid);
  } else {
    box_3d(box_inner, thickness, tabs);
  }
} else {
  if (lid) {
    box_2d(box_inner, thickness, tabs_with_lid);
  } else {
    box_2d(box_inner, thickness, tabs);
  }
}
