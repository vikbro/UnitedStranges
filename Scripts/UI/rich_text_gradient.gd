@tool
extends RichTextEffect
class_name RichTextGradient

# Syntax: [gradient][/gradient]
# Or: [gradient speed=1.0 span=10.0][/gradient]

var bbcode = "gradient"

@export var gradient: Gradient = Gradient.new()

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	if gradient == null:
		return false

	var speed = char_fx.env.get("speed", 1.0)
	var span = char_fx.env.get("span", 10.0)

	# Same wave formula as the ghost effect, but used to sample the gradient
	var t = fmod(
		char_fx.elapsed_time * speed + (char_fx.range.x / span),
		1.0
	)

	var gradient_color = gradient.sample(t)
	char_fx.color = gradient_color * char_fx.color
	return true
