// Units are mm.

// Attaches to the general-purpose mounting holes on the hub.
// Holds a pixhawk 4 mini.
// Holes on the side can be used to mount bars that connect to
// other mounts for telemetry module, GPS, etc.

use <common.scad>;

thickness = i2mm(0.25); // thickness of base plate, to which the hub is mounted.
offset = i2mm(1); // distance between base plate and bottom of pixhawk.

pixhawk_width = i2mm(1 + 9/16);
cutout_width = i2mm(1.15);
pixhawk_length = i2mm(2 + 3/16);

wall_thickness = 2;
side_wall_height = i2mm(1/8);
tip_wall_height = i2mm(1/16);

module walls() {
    fudge = 0.5;
    translate([wall_thickness / 2 + pixhawk_width / 2, 0, side_wall_height / 2])
        cube(size = [wall_thickness, pixhawk_length + wall_thickness * 2, side_wall_height + fudge], center = true);
    translate([-wall_thickness / 2 - pixhawk_width / 2, 0, side_wall_height / 2])
        cube(size = [wall_thickness, pixhawk_length + wall_thickness * 2, side_wall_height + fudge], center = true);
    translate([0, -wall_thickness / 2 - pixhawk_length / 2, tip_wall_height / 2])
        cube(size = [pixhawk_width, wall_thickness, tip_wall_height + fudge], center = true);
    translate([0, wall_thickness / 2 + pixhawk_length / 2, tip_wall_height / 2])
        cube(size = [pixhawk_width, wall_thickness, tip_wall_height + fudge], center = true);
}

module mount_holes() {
    diag = gp_mount_dim() * sqrt(2);
    translate([diag / 2, 0, 0]) {
        cylinder(r = hole_diam() / 2, h = 100, center = true, $fn = 25);
        translate([pixhawk_width / 2, 0, 0])
            cube(size = [pixhawk_width, hole_diam(), offset * 10], center = true);
    }
    translate([-diag / 2, 0, 0]) {
        cylinder(r = hole_diam() / 2, h = 100, center = true, $fn = 25);
        translate([-pixhawk_width / 2, 0, 0])
            cube(size = [pixhawk_width, hole_diam(), offset * 10], center = true);
    }
    translate([0, -diag / 2, 0]) {
        cylinder(r = hole_diam() / 2, h = 100, center = true, $fn = 25);
        translate([0, -pixhawk_length / 2, 0])
            cube(size = [hole_diam(), pixhawk_length, offset * 10], center = true);
    }
    translate([0, diag / 2, 0]) {
        cylinder(r = hole_diam() / 2, h = 100, center = true, $fn = 25);
        translate([0, pixhawk_length / 2, 0])
            cube(size = [hole_diam(), pixhawk_length, offset * 10], center = true);
    }
}

module tie_holes() {
    dim = i2mm(3/16);
    dy = 0.4 * pixhawk_length;
    translate([0, dy, 0])
        rotate([45, 0, 0])
            cube(size = [pixhawk_width * 2, dim, dim], center = true);
    translate([0, -dy, 0])
        rotate([45, 0, 0])
            cube(size = [pixhawk_width * 2, dim, dim], center = true);
}

difference() {
    union() {
        translate([0, 0, offset / 2])
            walls();
        // main block
        cube(size = [pixhawk_width + wall_thickness * 2, pixhawk_length + wall_thickness * 2, offset], center = true);
    }
    mount_holes();
    // block cutouts
    translate([0, 0, thickness])
        cube(size = [cutout_width, pixhawk_length * 2, offset], center = true);
    translate([0, 0, thickness])
        cube(size = [pixhawk_width * 2, i2mm(0.5), offset], center = true);
    tie_holes();
}
