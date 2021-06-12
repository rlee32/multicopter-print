// Units are mm.

// Binds avionics and sensors together: Pixhawk 4, GPS module, Telemetry module.

use <common.scad>;

width = i2mm(0.4375); // width of backbone.
h1 = i2mm(2.5); // height between PH4 and telemetry.
h2 = i2mm(2.5); // height between telemetry and GPS.

tab_thickness = i2mm(0.25); // thickness of tab that shares mounting screws with PH4 mount.
tab_length = i2mm(1);

dy = i2mm(0.5); // distance between mount holes.
htot = h1 + h2 + 3 * dy;

max_width = i2mm(2.5);
tab_hole_pos = max_width / 2 - gp_mount_dim() * sqrt(2) / 2;

module hole() {
    rotate([45, 0, 0])
        cube(size = [width * 2, hole_diam(), hole_diam()], center = true);
}

difference() {
    union() {
        cube(size = [width, htot, width], center = true);
        translate([width / 2 + tab_length / 2, -htot / 2 + tab_thickness / 2, 0])
            difference() {
                cube(size = [tab_length, tab_thickness, width], center = true);
                translate([-tab_length / 2 + tab_hole_pos, 0, 0])
                    rotate([0, 45, 0])
                        cube(size = [hole_diam(), tab_thickness * 2, hole_diam()], center = true);
            }
    }

    // mount holes.
    translate([0, -htot / 2 + h1, 0]) {
        hole();
        translate([0, dy, 0]) {
            hole();
            translate([0, h2, 0]) {
                hole();
                translate([0, dy, 0]) {
                    hole();
                }
            }
        }
    }
}

