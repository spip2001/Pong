extends Camera2D

@onready var shake_timer= $ 'ShakeTimer'

var shaking:bool = false

func _process(delta):
	if shaking:
		_do_shake()

func shake():
	if !shaking:
		shaking = true
		shake_timer.start()
		
func _do_shake():
	rotation = randf_range(-1.0, 1.0) * PI / 6

func _on_shake_timer_timeout():
	shake_timer.stop()
	shaking = false
	rotation = 0
