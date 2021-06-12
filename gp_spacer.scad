// Units are mm.

// Spacer between pixhawk mount and hub.

use <common.scad>;

thickness = i2mm(0.25);
width = i2mm(0.25);

module bar() {
    difference() {
        dy = gp_mount_dim() * sqrt(2);
        cube(size = [width, dy + hole_diam(), thickness], center = true);
        translate([0, -dy / 2 - hole_diam() / 2, 0])
            cube(size = [hole_diam(), hole_diam(), 2 * thickness], center = true);
        translate([0, -dy / 2, 0])
            cylinder(r = hole_diam() / 2, h = 2 * thickness, center = true, $fn = 20);
        translate([0, dy / 2 + hole_diam() / 2, 0])
            cube(size = [hole_diam(), hole_diam(), 2 * thickness], center = true);
        translate([0, dy / 2, 0])
            cylinder(r = hole_diam() / 2, h = 2 * thickness, center = true, $fn = 20);
    }
}

bar();
rotate([0, 0, 90])
    bar();
