include <boxmaker.scad>;

// Box inner dimensions
box_inner = [100, 70, 50];
// Material thickness (mm)
thickness = 3;

// Tab width (X, Y, Z, TopX, TopY) (mm)
tabs = [7, 7, 7, box_inner[0]/3, box_inner[1]/3];

// When there's no top, leave off the last two dimensions
tabs_no_top = [7, 7, 7];

box_with_lid();

translate([box_inner[0] + 20, 0, 0])
  box_without_top();

module box_with_lid() {
  // BEGIN 2D LAYOUT
  //layout_2d(box_inner, thickness) {
  // END 2D LAYOUT

  // BEGIN 3D PREVIEW
  color("black") cube(box_inner);
  layout_3d(box_inner, thickness) {
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

module box_without_top() {
  // BEGIN 2D LAYOUT
  //layout_2d(box_inner, thickness) {
  // END 2D LAYOUT

  // BEGIN 3D PREVIEW
  color("black") cube(box_inner);
  layout_3d(box_inner, thickness) {
  // END 3D PREVIEW
    // put this here to leave the lid off
    empty();
    difference() {
      side_a(box_inner, thickness, tabs_no_top);
        text("bottom");
    }
    difference() {
      side_b(box_inner, thickness, tabs_no_top);
        text("left");
    }
    difference() {
      side_b(box_inner, thickness, tabs_no_top);
        text("right");
    }
    difference() {
      side_c(box_inner, thickness, tabs_no_top);
        text("front");
    }
    difference() {
      side_c(box_inner, thickness, tabs_no_top);
        text("back");
    }
  }
}
