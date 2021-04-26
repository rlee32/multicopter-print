// Units are mm.

use <common.scad>;

arms = 8;

module arm(angle) {
    L = second_mount_radius() + arm_width() / 2;
    rotate([0, 0, angle])
        difference() {
            translate([-L / 2, 0, 0])
                cube(size = [L, arm_width(), hub_thickness()], center = true);
            translate([-second_mount_radius(), 0, 0])
                cube(size = [hole_diam(), hole_diam(), 2 * hub_thickness()], center = true);
            translate([-first_mount_radius(), 0, 0])
                cube(size = [hole_diam(), hole_diam(), 2 * hub_thickness()], center = true);
        }
}

difference() {
    union() {
        for (i = [0: 1: arms])
            arm(i * 360 / arms);
        d = gp_mount_dim() + 2 * gp_mount_margin() + hole_diam();
        cube(size = [d, d, hub_thickness()], center = true);
        translate([gp_mount_dim() / 2, gp_mount_dim() / 2, hub_thickness() / 2])
            spacer();
        translate([-gp_mount_dim() / 2, gp_mount_dim() / 2, hub_thickness() / 2])
            spacer();
        translate([-gp_mount_dim() / 2, -gp_mount_dim() / 2, hub_thickness() / 2])
            spacer();
        translate([gp_mount_dim() / 2, -gp_mount_dim() / 2, hub_thickness() / 2])
            spacer();
    }
    translate([gp_mount_dim() / 2, gp_mount_dim() / 2, 0])
        cube(size = [hole_diam(), hole_diam(), 2 * hub_thickness()], center = true);
    translate([-gp_mount_dim() / 2, gp_mount_dim() / 2, 0])
        cube(size = [hole_diam(), hole_diam(), 2 * hub_thickness()], center = true);
    translate([-gp_mount_dim() / 2, -gp_mount_dim() / 2, 0])
        cube(size = [hole_diam(), hole_diam(), 2 * hub_thickness()], center = true);
    translate([gp_mount_dim() / 2, -gp_mount_dim() / 2, 0])
        cube(size = [hole_diam(), hole_diam(), 2 * hub_thickness()], center = true);
}



