#ifndef _RUDDER_H_
#define _RUDDER_H_

/**
 * Retrieves the stored rudder data from the struct into
 * a packed uint8 array. Suitable for using in Matlab.
 */
void GetRudderData(unsigned char *data);

/**
 * Records the provided rudder data in a uint8 array
 * into a local tRudderData struct.
 */
void SetRudderData(unsigned char *data);

/**
 * Clears the stored rudder data to all zeros.
 */
void ClearRudderData();

#endif // _RUDDER_H_