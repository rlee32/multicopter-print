// Units are mm.

// Attaches to the general-purpose mounting holes on the hub.
// Holds a pixhawk 4 mini, telemetry module, and GPS module.

use <common.scad>;

thickness = i2mm(0.25); // thickness of base plate, to which the hub is mounted.
offset = i2mm(0.25); // distance between base plate and bottom of pixhawk.
base_plate_margin = i2mm(0.25); // minimum distance between base plate hole center and an edge.

pillar_width = i2mm(0.25);
pillar_length = i2mm(1.5);

wall_thickness = 2;
side_wall_height = i2mm(1/8);
tip_wall_height = i2mm(1/16);

base_plate_dim = 2 * base_plate_margin + gp_mount_dim();

difference() {
    cube(size = [base_plate_dim, base_plate_dim, thickness], center = true);
    dx = gp_mount_dim() / 2;

    translate([dx, dx, 0]) {
        cube(size = [hole_diam(), hole_diam(), 2 * thickness], center = true);
        translate([0, base_plate_margin, 0])
            cube(size = [hole_diam(), 2 * base_plate_margin, 2 * thickness], center = true);
    }

    translate([-dx, dx, 0]) {
        cube(size = [hole_diam(), hole_diam(), 2 * thickness], center = true);
        translate([0, base_plate_margin, 0])
            cube(size = [hole_diam(), 2 * base_plate_margin, 2 * thickness], center = true);
    }

    translate([-dx, -dx, 0]) {
        cube(size = [hole_diam(), hole_diam(), 2 * thickness], center = true);
        translate([0, -base_plate_margin, 0])
            cube(size = [hole_diam(), 2 * base_plate_margin, 2 * thickness], center = true);
    }

    translate([dx, -dx, 0]) {
        cube(size = [hole_diam(), hole_diam(), 2 * thickness], center = true);
        translate([0, -base_plate_margin, 0])
            cube(size = [hole_diam(), 2 * base_plate_margin, 2 * thickness], center = true);
    }

}

dx = pillar_width / 2 + base_plate_dim / 2;
translate([dx, 0, offset / 2]) {
    cube(size = [pillar_width, pillar_length, thickness + offset], center = true);
    translate([pillar_width / 2 + wall_thickness / 2, 0, side_wall_height / 2])
        cube(size = [wall_thickness, pillar_length + 2 * wall_thickness, thickness + offset + side_wall_height], center = true);
    translate([wall_thickness / 2, 0, tip_wall_height / 2]) {
        translate([0, pillar_length / 2 + wall_thickness / 2, 0])
            cube(size = [wall_thickness + pillar_width, wall_thickness, thickness + offset + tip_wall_height], center = true);
        translate([0, -(pillar_length / 2 + wall_thickness / 2), 0])
            cube(size = [wall_thickness + pillar_width, wall_thickness, thickness + offset + tip_wall_height], center = true);
    }
}

translate([-dx, 0, offset / 2]) {
    cube(size = [pillar_width, pillar_length, thickness + offset], center = true);
    translate([-(pillar_width / 2 + wall_thickness / 2), 0, side_wall_height / 2])
        cube(size = [wall_thickness, pillar_length + 2 * wall_thickness, thickness + offset + side_wall_height], center = true);
    translate([-wall_thickness / 2, 0, tip_wall_height / 2]) {
        translate([0, pillar_length / 2 + wall_thickness / 2, 0])
            cube(size = [wall_thickness + pillar_width, wall_thickness, thickness + offset + tip_wall_height], center = true);
        translate([0, -(pillar_length / 2 + wall_thickness / 2), 0])
            cube(size = [wall_thickness + pillar_width, wall_thickness, thickness + offset + tip_wall_height], center = true);
    }
}
