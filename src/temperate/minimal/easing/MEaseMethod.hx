package temperate.minimal.easing;

/**
 * @param	t - elapsed time since tween start, current time
 * @param	b - start value, value0
 * @param	c - change, value1 - value0, delta value
 * @param	d - duration, t1 - t0, delta time
 * @return	current value
 * 
 * 
 * b + c |                  **
 *     / |             *****
 *  c {  |       ******------- returned value
 *     \ | ******     |
 *     b -------------|-------
 *       |            t      |
 *       |<------ d -------->|
 * 
 */
typedef MEaseMethod = Float->Float->Float->Float->Float;