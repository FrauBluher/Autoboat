#ifndef _RUDDER_H_
#define _RUDDER_H_

#include <stdbool.h>

#include "types.h"

struct RudderData {
	tFloatToChar RudderAngle;
	tUnsignedShortToChar RudderPotValue;
	tUnsignedShortToChar RudderPotLimitStarboard;
	tUnsignedShortToChar RudderPotLimitPort;
	bool LimitHitStarboard;
	bool LimitHitPort;
	uint8_t RudderState; // Bitfield where 0th bit: enabled/disabled, 1st bit: calibrated, 2nd bit: calibrating, 
};
extern struct RudderData rudderSensorData;

/**
 * Returns the current vessel rudder angle. Units are in radians with positive values to port.
 */
float GetRudderAngle();

/**
 * Returns the rudder state as a 3-bit number following
 * from msg 0x8081 used with the rudder.
 */
uint8_t GetRudderStatus(void);

/**
 * Stores a recorded value of the rudder angle.
 */
void SetRudderAngle(const uint8_t data[2]);

/**
 * Clears the stored rudder data to all zeros.
 */
void ClearRudderAngle();

void RudderStartCalibration(void);

void RudderSendAngleCommand(float angleCommand);

#endif // _RUDDER_H_
