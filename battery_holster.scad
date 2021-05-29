// Units are mm.

// Holds 1 large composite battery.
// This is mounted beneath the hub, by zip ties around 4 of the arms:
// forward, back, left, right.

use <common.scad>;


battery_width = i2mm(3.25);
battery_length = i2mm(3);
drop_height = i2mm(3.25);

bottom_thic = 2;
arm_thic = i2mm(0.25);
arm_width = i2mm(0.625);
arm_sep = i2mm(0.51);
zip_tie_hole_diam = i2mm(0.23) / sqrt(2);
hole_separation = i2mm(1);
hole_tab_len = i2mm(0.375); // length beyond upper zip tie hole.

module arm() {
    z = drop_height + hole_separation + hole_tab_len;
    difference() {
        translate([0, 0, z/2])
            cube(size = [arm_thic, arm_width, z], center = true);
        translate([0, 0, z - hole_tab_len]) {
            rotate([45, 0, 0])
                cube(size = [2 * arm_thic, zip_tie_hole_diam, zip_tie_hole_diam], center = true);
            translate([0, 0, -hole_separation])
                rotate([45, 0, 0])
                    cube(size = [2 * arm_thic, zip_tie_hole_diam, zip_tie_hole_diam], center = true);
        }
    }
}

module arm_pair() {
    dx = arm_sep / 2 + arm_thic / 2;
    translate([-dx, 0, 0])
        arm();
    translate([dx, 0, 0])
        arm();

}

dy = battery_length / 2 + arm_width / 2;
translate([0, -dy, 0])
    arm_pair();
translate([0, dy, 0])
    arm_pair();

dx = battery_width / 2 + arm_width / 2;
translate([dx, 0, 0])
    rotate([0, 0, 90])
        arm_pair();
translate([-dx, 0, 0])
    rotate([0, 0, 90])
        arm_pair();

cube(size = [battery_width + arm_width * 2, battery_length + arm_width * 2, bottom_thic], center = true);
