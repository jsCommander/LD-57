extends RefCounted

class_name Animations

class BaseOptions:
	var duration: float = 1.0
	var ease_type: Tween.EaseType = Tween.EASE_IN_OUT
	var trans: Tween.TransitionType = Tween.TRANS_SINE

class RepeatedOptions extends BaseOptions:
	var loop: bool = true

class PulseOptions extends RepeatedOptions:
	var strength: float = 1.05

class ShakeOptions extends RepeatedOptions:
	var intensity: float = 3.0

class BounceOptions extends RepeatedOptions:
	var jump_height: float = -10.0
	
	func _init():
		trans = Tween.TRANS_BOUNCE

static func pulse(target: Node2D, options: PulseOptions = PulseOptions.new()) -> Tween:
	var tween = target.create_tween()
	
	if options.loop:
		tween.set_loops()
	
	tween.set_trans(options.trans)
	tween.set_ease(options.ease_type)
	
	tween.tween_property(target, "scale", target.scale * options.strength, options.duration / 2).from_current()
	tween.tween_property(target, "scale", target.scale, options.duration / 2)
	
	return tween

static func shake(target: Node2D, options: ShakeOptions = ShakeOptions.new()) -> Tween:
	var initial_pos = target.position
	var tween = target.create_tween()
	
	if options.loop:
		tween.set_loops()
	
	tween.set_trans(options.trans)
	tween.set_ease(options.ease_type)
	
	for i in range(4):
		tween.tween_property(target, "position",
			initial_pos + Vector2(randf_range(-options.intensity, options.intensity),
				randf_range(-options.intensity, options.intensity)),
			options.duration / 4
		)
	tween.tween_property(target, "position", initial_pos, options.duration / 4)
	
	return tween

static func fade_in(target: Node2D, duration: float = 1.0) -> Tween:
	target.modulate.a = 0.0
	var tween = target.create_tween()
	
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(target, "modulate:a", 1.0, duration)
	
	return tween

static func fade_out(target: Node2D, duration: float = 1.0) -> Tween:
	var tween = target.create_tween()
	
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(target, "modulate:a", 0.0, duration)

	return tween

static func bounce(target: Node2D, options: BounceOptions = BounceOptions.new()) -> Tween:
	var tween = target.create_tween()
	
	if options.loop:
		tween.set_loops()
	
	tween.set_trans(options.trans)
	tween.set_ease(options.ease_type)
	
	tween.tween_property(target, "position:y", target.position.y + options.jump_height, options.duration / 2)
	tween.tween_property(target, "position:y", target.position.y, options.duration / 2)
	
	return tween
