// Units are mm.

use <common.scad>;

// the motor is assumed to have a square bolt pattern arrangement.
// avoids geometric holes for more reliable print quality.

// distance between 2 mount holes, using the line that goes through the center of the motor.
mount_dim = 33;

// distance from hub center to motor center.
// assumes all motors are equidistant from center.
arm_length = i2mm(6 + 3/16);

arm_thickness = i2mm(0.375);

motor_mount_thickness = i2mm(0.25);

// shell thickness of spacer that separates the motor from the top surface arm.
spacer_thickness = 2;

// height of spacer that separates the motor from the top surface arm.
spacer_height = 2;

motor_mount_arm_width = i2mm(3/8);

module spacer() {
    difference() {
        h = motor_mount_thickness + spacer_height;
        od = hole_diam() + 2 * spacer_thickness;
        cube([od, od, h], center = true);
        id = hole_diam();
        cube([id, id, 2 * h], center = true);
    }
}

module motor_cross() {
    difference() {
        union() {
            extension = 0 * hole_diam() / 2;
            cube(size = [mount_dim + 2 * extension, motor_mount_arm_width, motor_mount_thickness], center = true);
            cube(size = [motor_mount_arm_width, mount_dim + 2 * extension, motor_mount_thickness], center = true);
            translate([0, 0, spacer_thickness / 2]) {
                translate([-mount_dim / 2, 0, 0])
                    spacer();
                translate([mount_dim / 2, 0, 0])
                    spacer();
                translate([0, mount_dim / 2, 0])
                    spacer();
                translate([0, -mount_dim / 2, 0])
                    spacer();
            }
        }

        cut_dim = 2 * hole_diam();
        cut_shift = hole_diam() / 2;
        translate([-mount_dim / 2 - cut_shift, 0, 0])
            cube(size = [cut_dim, hole_diam(), 2 * motor_mount_thickness], center = true);
        translate([mount_dim / 2 + cut_shift, 0, 0])
            cube(size = [cut_dim, hole_diam(), 2 * motor_mount_thickness], center = true);
        translate([0, mount_dim / 2 + cut_shift, 0])
            cube(size = [hole_diam(), cut_dim, 2 * motor_mount_thickness], center = true);
        translate([0, -mount_dim / 2 - cut_shift, 0])
            cube(size = [hole_diam(), cut_dim, 2 * motor_mount_thickness], center = true);
    }
}

rotate([0, 0, 45])
    motor_cross();
translate([-arm_length / 2, 0, 0])
    cube(size = [arm_length, arm_width(), arm_thickness], center = true);
