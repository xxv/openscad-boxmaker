include <boxmaker.scad>;

// Box inner dimensions
box_inner = [100, 70, 50];
// Material thickness (mm)
thickness = 3;
// Tab width (X, Y, Z) (mm)
tabs = [7, 7, 7];

show_3d = 0;

if (show_3d) {
  box_3d(box_inner, thickness, tabs);
} else {
  box_2d(box_inner, thickness, tabs);
}


