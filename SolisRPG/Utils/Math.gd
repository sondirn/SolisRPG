class_name Math

static func Clamp(value, minimum, maximum):
	if value > maximum:
		return maximum
	if value < minimum:
		return minimum
	return value
	
static func cartesian_to_isometric(cartesian: Vector2):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) / 2)
	
	
