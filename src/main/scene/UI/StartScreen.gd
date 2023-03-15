extends CanvasLayer

signal start_pressed

@onready var press_start_label:Label = $"PanelContainer/PressStartLabel"
@onready var ready_timer:Timer = $"ReadyTimer"

var ready_to_start:bool = false


func _ready():
	press_start_label.visible = false
	ready_timer.start()

func _process(delta):
	
	if ready_to_start and Input.is_action_pressed("ui_accept"):
		start_pressed.emit()
	
func _on_ready_timer_timeout():
	press_start_label.visible = true
	ready_to_start = true
