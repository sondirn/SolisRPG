class_name Math

static func Clamp(value, minimum, maximum):
	if value > maximum:
		return maximum
	if value < minimum:
		return minimum
	return value
