// Units are mm.

use <common.scad>;

// the motor is assumed to have a square bolt pattern arrangement.
// avoids geometric holes for more reliable print quality.

// distance between 2 mount holes, using the line that goes through the center of the motor.
mount_dim = 33;

// distance from hub center to motor center.
// assumes all motors are equidistant from center.
arm_length = i2mm(6 + 3/16);

motor_mount_thickness = arm_thickness();

motor_mount_arm_width = i2mm(3/8);

// For a downward-facing arm, set this to true to print a cylindrical landing leg.
landing_leg = false;
landing_leg_length = i2mm(5);
landing_leg_r1 = arm_width() / 2; // radius of base of landing leg.
landing_leg_r2 = arm_width() / 4; // radius of tip (ground-touching part) of landing leg.
landing_leg_position = 15; // landing leg position relative to second_mount_radius().

module motor_cross() {
    difference() {
        union() {
            extension = 0 * hole_diam() / 2;
            cube(size = [mount_dim + 2 * extension, motor_mount_arm_width, motor_mount_thickness], center = true);
            cube(size = [motor_mount_arm_width, mount_dim + 2 * extension, motor_mount_thickness], center = true);
            translate([0, 0, hub_thickness() / 2]) {
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
        cut_height = 4 * hub_thickness();
        translate([-mount_dim / 2 - cut_shift, 0, 0])
            cube(size = [cut_dim, hole_diam(), cut_height], center = true);
        translate([mount_dim / 2 + cut_shift, 0, 0])
            cube(size = [cut_dim, hole_diam(), cut_height], center = true);
        translate([0, mount_dim / 2 + cut_shift, 0])
            cube(size = [hole_diam(), cut_dim, cut_height], center = true);
        translate([0, -mount_dim / 2 - cut_shift, 0])
            cube(size = [hole_diam(), cut_dim, cut_height], center = true);
    }
}

rotate([0, 0, 45]) { // to facilitate better fit when print bed is size-limited.
    rotate([0, 0, 45])
        motor_cross();
    difference() {
        union() {
            arm_length_ = arm_length - first_mount_radius() + hole_diam() / 2;
            translate([-arm_length_ / 2, 0, 0])
                cube(size = [arm_length_, arm_width(), arm_thickness()], center = true);
            circle_resolution = 50;
            translate([-arm_length + second_mount_radius() + landing_leg_position, 0, 0])
                cylinder(h = landing_leg_length, r1 = landing_leg_r1, r2 = landing_leg_r2, $fn=circle_resolution);
        }
        cut_dim = 2 * hole_diam();
        cut_shift = hole_diam() / 2;
        translate([-arm_length + first_mount_radius() - cut_shift, 0, 0])
            cube(size = [cut_dim, hole_diam(), 2 * arm_thickness()], center = true);
        translate([-arm_length + second_mount_radius(), 0, 0])
            cube(size = [hole_diam(), hole_diam(), 2 * arm_thickness()], center = true);
    }
}
