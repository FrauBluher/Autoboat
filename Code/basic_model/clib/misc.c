#include "code_gen.h"

void initCalibrationRange() {
	uint16_T tmp;
	// Initialize rudder range
	if ((tmp = DataEERead(10)) != 0xFFFF) {
		rudderRange[0] = tmp;
	}
	if ((tmp = DataEERead(11)) != 0xFFFF) {
		rudderRange[1] = tmp;
	}
	// Initialize throttle range
	if ((tmp = DataEERead(12)) != 0xFFFF) {
		throttleRange[0] = tmp;
	}
	if ((tmp = DataEERead(13)) != 0xFFFF) {
		throttleRange[1] = tmp;
	}
	// Initialize track range
	if ((tmp = DataEERead(14)) != 0xFFFF) {
		trackRange[0] = tmp;
	}
	if ((tmp = DataEERead(15)) != 0xFFFF) {
		trackRange[1] = tmp;
	}
}