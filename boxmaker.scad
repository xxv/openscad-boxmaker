
module box_2d(inner, thickness, tabs, margin=2) {
  side_a(inner, thickness, tabs);
  translate([inner[0] + margin, 0, 0])
    side_a(inner, thickness, tabs);

  translate([(inner[0] + margin) * 2, 0, 0])
    side_b(inner, thickness, tabs);
  translate([(inner[0] + margin) * 2 + inner[2] + margin, 0, 0])
    side_b(inner, thickness, tabs);

  translate([inner[0] + margin, inner[1] + margin, 0])
    side_c(inner, thickness, tabs);
  translate([0, inner[1] + margin, 0])
    side_c(inner, thickness, tabs);
}

// An assembled version of the box.
module box_3d(inner, thickness, tabs) {
  color("red") {
    linear_extrude(height=thickness)
      side_a(box_inner, thickness, tabs);

    translate([0, 0, box_inner[2]-thickness])
      linear_extrude(height=thickness)
        side_a(box_inner, thickness, tabs);
  }

  color("green") {
    translate([box_inner[0] - thickness, 0, thickness])
      rotate([0, -90, 0])
        linear_extrude(height=thickness)
          side_b(box_inner, thickness, tabs);

    translate([0, 0, thickness])
      rotate([0, -90, 0])
        linear_extrude(height=thickness)
          side_b(box_inner, thickness, tabs);
  }

  color("blue") {
    translate([0, 0, thickness])
      rotate([90, 0, 0])
        linear_extrude(height=thickness)
          side_c(box_inner, thickness, tabs);

    translate([0, box_inner[1]-thickness, thickness])
      rotate([90, 0, 0])
        linear_extrude(height=thickness)
          side_c(box_inner, thickness, tabs);
  }
}

// top/bottom
module side_a(inner, thickness, tabs) {
  side([inner[0], inner[1]],
       thickness,
       [tabs[0], tabs[1], tabs[0], tabs[1]],
       [0, 0, 0, 0]);
}

// left/right
module side_b(inner, thickness, tabs) {
  side([inner[2], inner[1]],
       thickness,
       [tabs[2], tabs[1], tabs[2], tabs[1]],
       [0, 1, 0, 1]);
}

// front/back
module side_c(inner, thickness, tabs) {
  side([inner[0], inner[2]],
       thickness,
       [tabs[0], tabs[2], tabs[0], tabs[2]],
       [1, 1, 1, 1]);
}

module side(inner, thickness, tabs, polarity) {
  SMIDGE = 0.1;

  translate([-thickness, -thickness])
    difference() {
      square([inner[0], inner[1]]);

      // bottom
      if (tabs[2] > 0)
        translate([0, -SMIDGE, 0])
          edge_cuts(inner[0], tabs[2], thickness + SMIDGE, polarity[2]);

      // top
      if (tabs[0] > 0)
        translate([0, inner[1] - thickness, 0])
          edge_cuts(inner[0], tabs[0], thickness + SMIDGE, polarity[0]);

      rotate([0, 0, -90]) {
        translate([-inner[1], 0, 0]) {
          // left
          if (tabs[3] > 0)
            translate([0, -SMIDGE, 0])
              edge_cuts(inner[1], tabs[3], thickness + SMIDGE, polarity[3]);

          // right
          if (tabs[1] > 0)
            translate([0, inner[0] - thickness, 0])
              edge_cuts(inner[1], tabs[1], thickness + SMIDGE, polarity[1]);
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
