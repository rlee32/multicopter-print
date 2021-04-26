// this contains functions and parameters common to both arm and hub files.

// converts x in inches to x in mm.
function i2mm(x) = x * 0.0254 * 1000;

// distance from hub center to first arm mount point. must be less than second arm mount point.
function first_mount_radius() = i2mm(1);

// distance from hub center to second arm mount point. must be greater than first arm mount point.
function second_mount_radius() = i2mm(2);

// diameter of hole for fasteners between arm and hub.
function hole_diam() = i2mm(1/8) + 0.25;

function arm_width() = i2mm(0.5);

// thickness of each of the 2 hub plates.
function hub_thickness() = i2mm(.25);

// thickness of each of arm plate.
function arm_thickness() = i2mm(0.25);

// distance between general-purpose mounting holes arranged in a square.
function gp_mount_dim() = i2mm(0.75);

// minimum distance to edge from general-purpose mounting holes.
function gp_mount_margin() = i2mm(0.125);

// makes the spacer that accomodates 1 arm plate and 1 hub plate.
module spacer() {
    // shell thickness of spacer that separates the motor from the top surface arm.
    spacer_thickness = 2;
    difference() {
        h = hub_thickness() + arm_thickness();
        od = hole_diam() + 2 * spacer_thickness;
        cube([od, od, h], center = true);
        id = hole_diam();
        cube([id, id, 2 * h], center = true);
    }
}

