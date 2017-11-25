include <boxmaker.scad>;

// Box inner dimensions
box_inner = [100, 70, 50];
// Material thickness (mm)
thickness = 3;

// Tab width (X, Y, Z, TopX, TopY) (mm)
// The TopX and TopY here create a nice easy-to-open lid.
tabs_with_lid = [7, 7, 7, box_inner[0]/3, box_inner[1]/3];

box_with_lid(box_inner, thickness, tabs_with_lid);

// When there's no top, leave off the last two dimensions
// Tab width (X, Y, Z) (mm)
tabs_no_top = [7, 7, 7];

translate([box_inner[0] + 20, 0, 0])
  box_without_top(box_inner, thickness, tabs_no_top);

module box_with_lid(box_inner, thickness, tabs) {
  // Due to the limitations of OpenSCAD, the best way to allow for the same
  // geometry to be used in both the 3D and 2D previews is to comment /
  // uncomment portions of the code. Please comment/uncomment the appropriate
  // BEGIN/END sections below.

  // BEGIN 2D LAYOUT
  //layout_2d(box_inner, thickness) {
  // END 2D LAYOUT

  // BEGIN 3D PREVIEW
  color("black") cube(box_inner); layout_3d(box_inner, thickness) {
  // END 3D PREVIEW

    difference() {
      side_a_top(box_inner, thickness, tabs);
      text("top");
      translate([box_inner[0] / 2, box_inner[1] / 2])
        circle(r=10);
    }

    difference() {
      side_a(box_inner, thickness, tabs);
      text("bottom");
    }

    difference() {
      side_b(box_inner, thickness, tabs);
      text("left");
    }

    difference() {
      side_b(box_inner, thickness, tabs);
      text("right");
    }

    difference() {
      side_c(box_inner, thickness, tabs);
      text("front");
    }

    difference() {
      side_c(box_inner, thickness, tabs);
      text("back");
    }
  }
}

module box_without_top(box_inner, thickness, tabs) {
  // Due to the limitations of OpenSCAD, the best way to allow for the same
  // geometry to be used in both the 3D and 2D previews is to comment /
  // uncomment portions of the code. Please comment/uncomment the appropriate
  // BEGIN/END sections below.

  // BEGIN 2D LAYOUT
  //layout_2d(box_inner, thickness) {
  // END 2D LAYOUT

  // BEGIN 3D PREVIEW
  color("black") cube(box_inner); layout_3d(box_inner, thickness) {
  // END 3D PREVIEW

    // put this here to leave the lid off
    // Top
    empty();

    difference() {
      side_a(box_inner, thickness, tabs);
      text("bottom");
    }

    difference() {
      side_b(box_inner, thickness, tabs);
      text("left");
    }

    difference() {
      side_b(box_inner, thickness, tabs);
      text("right");
    }

    difference() {
      side_c(box_inner, thickness, tabs);
      text("front");
    }

    difference() {
      side_c(box_inner, thickness, tabs);
      text("back");
    }
  }
}
