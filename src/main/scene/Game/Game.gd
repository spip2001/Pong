extends Node2D

@onready var ball = $'Ball'
var p1_start = true

# Called when the node enters the scene tree for the first time.
func _ready():
	ball.kick_off()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

	
