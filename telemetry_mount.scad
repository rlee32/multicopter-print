// Units are mm.

// Holds a HolyBro Telemetry Radio.
// Holes on the side can be used to mount bars that connect to the main mount.

use <common.scad>;

thickness = i2mm(0.125); // thickness of base plate, to which the hub is mounted.
offset = i2mm(1.25); // distance between base plate and bottom of telemetry module.

telem_width = i2mm(1 + 1/8);
cutout_width = i2mm(0.75);
telem_length = i2mm(1 + 7/8);

wall_thickness = 2;
side_wall_height = i2mm(1/8);
tip_wall_height = i2mm(1/8);

module walls() {
    fudge = 0.5;
    translate([wall_thickness / 2 + telem_width / 2, 0, side_wall_height / 2])
        cube(size = [wall_thickness, telem_length + wall_thickness * 2, side_wall_height + fudge], center = true);
    translate([-wall_thickness / 2 - telem_width / 2, 0, side_wall_height / 2])
        cube(size = [wall_thickness, telem_length + wall_thickness * 2, side_wall_height + fudge], center = true);
    translate([-telem_width / 4, -wall_thickness / 2 - telem_length / 2, tip_wall_height / 2])
        cube(size = [telem_width / 2, wall_thickness, tip_wall_height + fudge], center = true);
    translate([telem_width / 4, wall_thickness / 2 + telem_length / 2, tip_wall_height / 2])
        cube(size = [telem_width / 2, wall_thickness, tip_wall_height + fudge], center = true);
}

module tie_holes() {
    dim = i2mm(3/16);
    dy = 0.35 * telem_length;
    z = i2mm(0.25);
    translate([0, dy, z])
        rotate([45, 0, 0])
            cube(size = [telem_width * 2, dim, dim], center = true);
    translate([0, -dy, z])
        rotate([45, 0, 0])
            cube(size = [telem_width * 2, dim, dim], center = true);
}

module mount_holes() {
    dz =  i2mm(0.5);
    z = i2mm(0.0625);
    translate([0, 0, z + dz / 2])
        rotate([45, 0, 0])
            cube(size = [telem_width * 2, hole_diam(), hole_diam()], center = true);
    translate([0, 0, z - dz / 2])
        rotate([45, 0, 0])
            cube(size = [telem_width * 2, hole_diam(), hole_diam()], center = true);
}


difference() {
    union() {
        translate([0, 0, offset / 2])
            walls();
        // main block
        cube(size = [telem_width + wall_thickness * 2, telem_length + wall_thickness * 2, offset], center = true);
    }
    // block cutouts
    translate([0, 0, thickness + offset / 2])
        cube(size = [cutout_width, telem_length * 2, 2 * offset], center = true);
    tie_holes();
    mount_holes();
}
