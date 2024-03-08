global.roll_index++;

// we only do this so we store the total pins knocked down,
// but only the pins we've knocked down since the last roll
if (global.pins_locked) {
	global.roll[global.roll_index] = global.pins - global.roll[global.roll_index-1];
} else {
	global.roll[global.roll_index] = global.pins;
}

if (global.pins < 10 && global.pins > 0) {
	global.pins_locked = !global.pins_locked;
	if (!global.pins_locked) {
		pin_reset();
	}
}

// lock pins
with (obj_pin) {
	if (down && global.pins_locked) {
		selectable = false;
	} else {
		selectable = true;
		down = 0;
	}
}

// update score object
with (obj_score) {
	if (current_frame != 9) {
		if (frame_roll == 1) {
			frame[current_frame].roll1 = global.roll_index;
			if (global.pins == 10) { // strike
				current_frame++;
			} else {
				frame_roll = 2;
			}
		} else {
			frame[current_frame].roll2 = global.roll_index;
			current_frame++;
			frame_roll = 1;
		}
	} else {	// 10th frame
		if (frame_roll == 1) {
			frame[current_frame].roll1 = global.roll_index;
			frame_roll = 2;
		} else if (frame_roll == 2) {
			frame[current_frame].roll2 = global.roll_index;
			frame_roll = 3;
			if (global.roll[frame[9].roll1] + global.roll[frame[9].roll2] < 10) {
				instance_destroy(obj_submitscore);
			}
		} else {
			frame[current_frame].roll3 = global.roll_index;
			instance_destroy(obj_submitscore);
		}
	}
}

if (global.pins == 10) {
	pin_reset();
}



















































































































































































































































































































































































