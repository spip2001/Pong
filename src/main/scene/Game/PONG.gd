extends Node2D

@onready var game = $"Game"


# Called when the node enters the scene tree for the first time.
func _ready():
	game.process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
