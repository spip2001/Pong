class_name Ball
extends Node2D

const BASE_SPEED = 500

var speed = BASE_SPEED
var velocity = Vector2.ZERO
var self_rotation = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Move ball
	position += velocity * delta
	# Rotate ball
	rotate(self_rotation * delta)

func set_direction(dir:Vector2):
	dir = dir.normalized()
	if abs(dir.x) < 0.4:
		dir = Vector2(
			(1 if dir.x >= 0 else -1) * 0.707, 
			(1 if dir.y >= 0 else -1) * 0.707) 
	velocity = dir * speed
	
func set_self_rotation(angular_speed:float):
	self_rotation = angular_speed

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var player_normal = Vector2(randf_range(0.8, 1.2),randf_range(-0.2, 0.2)).normalized()
		var v0 = velocity.normalized()
		velocity = (2 * player_normal) * (v0 * -1).dot(player_normal) - (v0 * -1)
		speed *= 1.05
		velocity = (velocity.normalized()) * speed
	elif body.is_in_group("Wall"):
		var wall:Wall = body
		var wall_normal = wall.normal
		var v0 = velocity.normalized()
		velocity = (2 * wall_normal) * (v0 * -1).dot(wall_normal) - (v0 * -1)
		speed *= 1.05
		velocity = (velocity.normalized()) * speed


func _on_area_entered(area):
	if area is Goal:
		kick_off(true)
		
func kick_off(p1_start: bool):
	speed = BASE_SPEED
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y / 2
	
	var dir = -1 if p1_start else 1
	
	set_direction(Vector2(dir * randf_range(0.7, 1.3), randf_range(-0.3, 0.3)))
	set_self_rotation(2 * PI)
