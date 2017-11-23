include <boxmaker.scad>;

// Box inner dimensions
box_inner = [100, 70, 50];
// Material thickness (mm)
thickness = 3;
// Tab width (X, Y, Z) (mm)
tabs = [7, 7, 7];

//layout_2d(box_inner, thickness) {
color("black") cube(box_inner);
layout_3d(box_inner, thickness) {
  difference() {
    side_a(box_inner, thickness, tabs);
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
