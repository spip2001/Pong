extends Node2D

@onready var game = $"Game"
@onready var start_screen = $"StartScreen"


# Called when the node enters the scene tree for the first time.
func _ready():
	game.process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _start_game():
	start_screen.visible = false
	start_screen.process_mode = Node.PROCESS_MODE_DISABLED
	game.process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_start_screen_start_pressed():
	_start_game()
	

