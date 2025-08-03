class_name Math
extends Node


static func factorial(number: int) -> int:
	if number >= 0 and number <= 2:
		return number

	return number * factorial(number - 1)
