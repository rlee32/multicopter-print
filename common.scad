// this contains functions and parameters common to both arm and hub files.

// converts x in inches to x in mm.
function i2mm(x) = x * 0.0254 * 1000;

// distance from hub center to first arm mount point. must be less than second arm mount point.
function first_mount_radius() = i2mm(1);

// distance from hub center to second arm mount point. must be greater than first arm mount point.
function second_mount_radius() = i2mm(2);

// diameter of hole for fasteners between arm and hub.
function hole_diam() = i2mm(1/8) + 0.5;

function arm_width() = i2mm(0.5);
