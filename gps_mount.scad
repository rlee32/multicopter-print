// Units are mm.

// Holds a Pixhawk 4 GPS module.
// Holes on the side can be used to mount bars that connect to the main mount.

use <common.scad>;

thickness = i2mm(0.125); // thickness of base plate, to which the hub is mounted.

module_diam = i2mm(2);

wall_thickness = 2;
wall_height = i2mm(1/2);

outlet_width = i2mm(3/8);
switch_width = i2mm(1/4);

module mount_pillars() {
    z = i2mm(1);
    dz =  i2mm(.625);
    h = 3 * dz;
    w = 4 * hole_diam();
    max_width = i2mm(2.5);
    extension = (max_width - module_diam) / 2;
    difference() {
        union() {
            translate([module_diam / 2 + wall_thickness / 2 + extension / 2, 0, h / 2 - (thickness + wall_height) / 2])
                cube(size = [extension + wall_thickness, w, h], center = true);
            translate([-(module_diam / 2 + wall_thickness / 2 + extension / 2), 0, h / 2 - (thickness + wall_height) / 2])
                cube(size = [extension + wall_thickness, w, h], center = true);
        }
        translate([0, 0, z + dz / 2])
            rotate([45, 0, 0])
                cube(size = [module_diam * 2, hole_diam(), hole_diam()], center = true);
        translate([0, 0, z - dz / 2])
            rotate([45, 0, 0])
                cube(size = [module_diam * 2, hole_diam(), hole_diam()], center = true);
    }
}

difference() {
    od = wall_thickness * 2 + module_diam;
    h = wall_height + thickness;
    cylinder(r = od / 2, h = h, center = true);
    translate([0, 0, thickness]) {
        cylinder(r = module_diam / 2, h = h, center = true);
        translate([0, -module_diam / 2, 0])
            cube(size = [outlet_width, module_diam, h], center = true);
        rotate([0, 0, 120])
            translate([0, -module_diam / 2, 0])
                cube(size = [outlet_width, module_diam, h], center = true);
    }
}
mount_pillars();
/*
difference() {
    union() {
        translate([0, 0, thickness / 2])
            walls();
        // main block
        cube(size = [module_diam + wall_thickness * 2, telem_length + wall_thickness * 2, thickness], center = true);
        mount_pillars();
    }
}
*/
