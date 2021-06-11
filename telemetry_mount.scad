// Units are mm.

// Holds a HolyBro Telemetry Radio.
// Holes on the side can be used to mount bars that connect to the main mount.

use <common.scad>;

thickness = i2mm(0.125); // thickness of base plate, to which the hub is mounted.

telem_width = i2mm(1 + 1/8);
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

module mount_pillars() {
    z = i2mm(1);
    dz =  i2mm(.5);
    h = 3 * dz;
    w = 3 * hole_diam();
    max_width = i2mm(2.5);
    extension = max_width / 2 - telem_width / 2;
    difference() {
        union() {
            translate([telem_width / 2 + wall_thickness / 2 + extension / 2, 0, h / 2 - thickness / 2])
                cube(size = [extension + wall_thickness, w, h], center = true);
            translate([-(telem_width / 2 + wall_thickness / 2 + extension / 2), 0, h / 2 - thickness / 2])
                cube(size = [extension + wall_thickness, w, h], center = true);
        }
        translate([0, 0, z + dz / 2])
            rotate([45, 0, 0])
                cube(size = [max_width * 2, hole_diam(), hole_diam()], center = true);
        translate([0, 0, z - dz / 2])
            rotate([45, 0, 0])
                cube(size = [max_width * 2, hole_diam(), hole_diam()], center = true);
    }
}

difference() {
    union() {
        translate([0, 0, thickness / 2])
            walls();
        // main block
        cube(size = [telem_width + wall_thickness * 2, telem_length + wall_thickness * 2, thickness], center = true);
        mount_pillars();
    }
}
