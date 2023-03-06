extends CharacterBody2D

@export_node_path("Ball") var ball_node_path
@onready var ball = get_node(ball_node_path)

const SPEED = 300.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir:Vector2 = Vector2.ZERO
	var middle = get_viewport_rect().size.y / 2
	
	if ball.velocity.x > 0 :
		dir.y = -1 if ball.position.y < position.y else 1
	elif abs(position.y - middle) > 5 :
		dir.y = -1 if position.y > middle else 1
	
	velocity = dir * SPEED
	
	move_and_slide()
