// Units are mm.

// Holds a telemetry module.
// Mounted via side tubes, which are in turn attached to the pixhwak mount and GPS module.

use <common.scad>;

thickness = i2mm(0.25); // thickness of base plate, to which the hub is mounted.
offset = i2mm(1); // distance between base plate and bottom of pixhawk.
base_plate_margin = i2mm(0.25); // minimum distance between base plate hole center and an edge.

pixhawk_width = i2mm(1 + 9/16);
pixhawk_length = i2mm(2 + 3/16);

wall_thickness = 2;
side_wall_height = i2mm(1/8);
tip_wall_height = i2mm(1/16);

side_hole_z = i2mm(0.25); // z-position of bottom-most side hole, from top of bas plate.
side_hole_dz = i2mm(0.5); // z-position of top-most side hole, from bottom-most side hole.
side_hole_y = i2mm(0); // y-position of side holes.

// derived parameters.

pillar_width = i2mm(0.25);
pillar_length = i2mm(1.5);

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

difference() {

    union() {

        // right pillar
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

        // left pillar
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

    }

    translate([0, 0, side_hole_z + thickness / 2])
        rotate([45, 0, 0])
            cube(size = [2 * pixhawk_width, hole_diam(), hole_diam()], center = true);
    translate([0, 0, side_hole_dz + side_hole_z + thickness / 2])
        rotate([45, 0, 0])
            cube(size = [2 * pixhawk_width, hole_diam(), hole_diam()], center = true);

    corner_cut_dim = 1.5 * pillar_width;
    dx = base_plate_dim / 2 + pillar_width + wall_thickness;
    dz = -thickness / 2;
    translate([dx, 0, dz])
        rotate([0, 45, 0])
            cube(size = [corner_cut_dim, 2 * pillar_length, corner_cut_dim], center = true);
    translate([-dx, 0, dz])
        rotate([0, 45, 0])
            cube(size = [corner_cut_dim, 2 * pillar_length, corner_cut_dim], center = true);
}
