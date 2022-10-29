extends Object

class_name Units

static func kg(quantity : int) -> float:
	return float(quantity)

static func g(quantity : int) -> float:
	return quantity / 1000.0

static func mm3(quantity : int) -> float:
	return quantity / 1000000000.0

static func cm3(quantity : int) -> float:
	return quantity / 1000000.0

static func dm3(quantity : int) -> float:
	return quantity / 1000.0
	
static func m3(quantity : int) -> float:
	return float(quantity)

static func L(quantity : int) -> float:
	return dm3(quantity)

static func mL(quantity : int) -> float:
	return cm3(quantity)

static func format_percentage(percentage : float) -> String:	
	return "%1.1f%%" % percentage

static func format_weight(weight : float) -> String:
	if weight >= kg(1):
		return "%1.3f kg" % (weight / kg(1))
	if weight >= g(1):
		return "%1.3f g" % (weight / g(1))
	return "%1.3f kg" % (weight / kg(1))

static func format_volume(volume : float) -> String:	
	if volume >= m3(1):
		return "%1.3f m^3" % (volume / m3(1))
	if volume >= dm3(1):
		return "%1.3f dm^3" % (volume / dm3(1))
	if volume >= cm3(1):
		return "%1.3f cm^3" % (volume / cm3(1))
	return "%1.3f m^3" % (volume / m3(1))
