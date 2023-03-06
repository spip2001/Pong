extends Node2D

@onready var ball:Ball = $'MainLayer/Ball'
@onready var player1_score = $'UI/ScorePanel/ScoreGrid/Player1Score'
@onready var player2_score = $'UI/ScorePanel/ScoreGrid/Player2Score'
@onready var goal_player = $'GoalPlayer'
@onready var goal_timer = $'GoalTimer'
@onready var camera = $'MainLayer/Camera2D'

var player1_score_counter = 0
var player2_score_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_refresh_scores()
	ball.reset_position()
	goal_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Calles when a goal is score
# player : the player that goaled index (1 or 2)	
func _on_ball_goal_scored(player:int):
	if player == 1 :
		player1_score_counter += 1
	else:
		player2_score_counter += 1
	_refresh_scores()
	goal_player.play()
	ball.reset_position()
	goal_timer.start()
	camera.shake()

# Refresh scores displayed
func _refresh_scores():
	player1_score.text = str(player1_score_counter)
	player2_score.text = str(player2_score_counter)
	
func _on_goal_timer_timeout():
	goal_timer.stop()
	ball.kick_off()
