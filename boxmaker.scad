/*
 * A finger-jointed lasercut box maker OpenSCAD library.
 *
 * Includes code from https://www.thingiverse.com/thing:448592/
 * http://boxdesigner.connectionlab.org/
 */
module box_2d(box_inner, thickness, tabs, margin=2) {
  layout_2d(box_inner, thickness) {
    side_a_top(box_inner, thickness, tabs);
    side_a(box_inner, thickness, tabs);
    side_b(box_inner, thickness, tabs);
    side_b(box_inner, thickness, tabs);
    side_c(box_inner, thickness, tabs);
    side_c(box_inner, thickness, tabs);
  }
}

// An assembled version of the box for previewing.
module box_3d(inner, thickness, tabs) {
  layout_3d(box_inner, thickness) {
    side_a_top(box_inner, thickness, tabs);
    side_a(box_inner, thickness, tabs);
    side_b(box_inner, thickness, tabs);
    side_b(box_inner, thickness, tabs);
    side_c(box_inner, thickness, tabs);
    side_c(box_inner, thickness, tabs);
  }
}

module layout_2d(inner, thickness, margin=2) {
  spacingA = inner[0] + thickness * 2 + margin;
  spacingB = inner[1] + thickness * 2 + margin;

  // bottom
  children(0);
  // top
  translate([spacingA, 0, 0])
    children(1);
  // left
  translate([spacingA * 2, inner[1], 0])
    rotate([0, 0, -90])
      children(2);
  // right
  translate([spacingA * 2 + inner[2] + thickness * 2 + margin, inner[1], 0])
    rotate([0, 0, -90])
      children(3);
  // front
  translate([0, inner[1] + margin + thickness * 2, 0])
    children(4);
  // back
  translate([inner[0] + margin + thickness * 2,
             inner[1] + margin + thickness * 2, 0])
    children(5);
}

module layout_2d_horizontal(inner, thickness, margin=2) {
  spacingA = inner[0] + thickness * 2 + margin;
  spacingB = inner[1] + thickness * 2 + margin;

  // bottom
  children(0);
  // top
  translate([spacingA, 0, 0])
    children(1);
  // left
  translate([spacingA * 2, spacingB, 0])
      children(2);
  // right
  translate([spacingA * 2 + spacingB, spacingB, 0])
      children(3);
  // front
  translate([0, spacingB, 0])
    children(4);
  // back
  translate([spacingA, spacingB, 0])
    children(5);
}

// An assembled version of the box for previewing.
module layout_3d(box_inner, thickness) {
  color("red") {
    // top
    translate([0, 0, box_inner[2]])
      linear_extrude(height=thickness)
        children(0);

    // bottom
    translate([0, box_inner[1], 0])
      rotate([180, 0, 0])
        linear_extrude(height=thickness)
          children(1);
  }

  color("green") {
    // left
    translate([0, box_inner[1], 0])
      rotate([90, 0, -90])
        linear_extrude(height=thickness)
          children(2);

    // right
    translate([box_inner[0], 0, 0])
      rotate([90, 0, 90])
        linear_extrude(height=thickness)
          children(3);
  }

  // front
  color("blue") {
    translate([0, 0, 0])
      rotate([90, 0, 0])
        linear_extrude(height=thickness)
          children(4);

    // back
    translate([box_inner[0], box_inner[1], 0])
      rotate([90, 0, 180])
        linear_extrude(height=thickness)
          children(5);
  }
}

module side_a_top(inner, thickness, tabs) {
  side([inner[0], inner[1]],
       thickness,
       [tabs[3], tabs[4], tabs[3], tabs[4]],
       [0, 0, 0, 0]);
}

module side_a(inner, thickness, tabs) {
  side([inner[0], inner[1]],
       thickness,
       [tabs[0], tabs[1], tabs[0], tabs[1]],
       [0, 0, 0, 0]);
}

// left/right
module side_b(inner, thickness, tabs) {
  side([inner[1], inner[2]],
       thickness,
       [tabs[4], tabs[2], tabs[1], tabs[2]],
       [1, 0, 1, 0]);
}

// front/back
module side_c(inner, thickness, tabs) {
  side([inner[0], inner[2]],
       thickness,
       [tabs[3], tabs[2], tabs[0], tabs[2]],
       [1, 1, 1, 1]);
}

module side(inner, thickness, tabs, polarity) {
  SMIDGE = 0.1;
  x = inner[0] + thickness * 2;
  y = inner[1] + thickness * 2;

  translate([-thickness, -thickness])
    difference() {
      square([x, y]);

      // bottom
      if (tabs[2] > 0)
        translate([0, -SMIDGE, 0])
          edge_cuts(x, tabs[2], thickness + SMIDGE, polarity[2]);

      // top
      if (tabs[0] > 0)
        translate([0, y - thickness, 0])
          edge_cuts(x, tabs[0], thickness + SMIDGE, polarity[0]);

      rotate([0, 0, -90]) {
        translate([-y, 0, 0]) {
          // left
          if (tabs[3] > 0)
            translate([0, -SMIDGE, 0])
              edge_cuts(y, tabs[3], thickness + SMIDGE, polarity[3]);

          // right
          if (tabs[1] > 0)
            translate([0, x - thickness, 0])
              edge_cuts(y, tabs[1], thickness + SMIDGE, polarity[1]);
          }
        }
    }
}

module edge_cuts(length, finger_width, cut_depth, polarity) {
  if (polarity == 0) {
    outside_cuts(length, finger_width, cut_depth);
  } else {
    difference() {
      square([length, cut_depth]);
      outside_cuts(length, finger_width, cut_depth);
    }
  }
}

// This module below based https://www.thingiverse.com/thing:448592/
// Customizable Box with Finger Joints by txoof
// licensed under the Creative Commons - Attribution license.

//cuts that fall at the end of an edge requiring an extra long cut
module outside_cuts(length, finger_width, cut_depth) {
  //Calculate the maximum number of fingers and cuts possible
  maxDiv = floor(length / finger_width);

  //the usable divisions value must be odd for this layout
  uDiv = (maxDiv % 2) == 0 ? maxDiv - 3 : maxDiv - 2;

  numFinger = ceil(uDiv / 2);
  numCuts = floor(uDiv / 2);
  //calculate the length of the extra long cut
  endCut = (length - uDiv * finger_width)/2;
  //amount of padding to add to the iterative placement of cuts
  // this is the extra long cut at the beginning and end of the edge
  padding=endCut + finger_width;

  square([endCut, cut_depth]);

  for (i=[0:numCuts]) {
    if (i < numCuts) {
      translate([i*(finger_width*2)+padding, 0, 0])
        square([finger_width, cut_depth]);
    } else {
      translate([i*(finger_width*2)+padding, 0, 0])
        square([endCut, cut_depth]);
    }
  }
}

module empty() {
  // Used if you don't want a given side.
}
