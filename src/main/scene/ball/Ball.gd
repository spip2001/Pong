class_name Ball
extends Node2D

signal goal_scored

@export_node_path("CharacterBody2D") var player1_node_path
@export_node_path("CharacterBody2D") var player2_node_path

const BASE_SPEED = 500

@onready var player1:CharacterBody2D = get_node(player1_node_path)
@onready var player2:CharacterBody2D = get_node(player2_node_path)
@onready var bouncing_player = $"BouncingPlayer"

var speed = BASE_SPEED
var velocity = Vector2.ZERO
var self_rotation = 0
var player1_serve:bool = true


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
		bouncing_player.play()
	elif body.is_in_group("Wall"):
		var wall:Wall = body
		var wall_normal = wall.normal
		var v0 = velocity.normalized()
		velocity = (2 * wall_normal) * (v0 * -1).dot(wall_normal) - (v0 * -1)
		speed *= 1.05
		velocity = (velocity.normalized()) * speed
		bouncing_player.play()

func _on_area_entered(area):
	if area is Goal:
		var goal:Goal = area
		player1_serve = !goal.player1
		goal_scored.emit(2 if goal.player1 else 1)
		speed = 0
		
func reset_position():
	position.x = player1.position.x + 20 if  player1_serve else player2.position.x -20
	position.y = player1.position.y if  player1_serve else player2.position.y
		
func kick_off():
	speed = BASE_SPEED
	reset_position()
	
	var dir = 1 if player1_serve else -1
	
	set_direction(Vector2(dir * randf_range(0.7, 1.3), randf_range(-0.3, 0.3)))
	set_self_rotation(2 * PI)
