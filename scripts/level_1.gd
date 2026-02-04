extends Node2D

@onready var ball_node: CharacterBody2D = get_node("Ball")
var initial_ball_pos: Vector2

func _ready():
	initial_ball_pos = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 30)
	ball_node.position = initial_ball_pos

func reset_ball():
	ball_node.position = initial_ball_pos
	ball_node.reset()

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("bolinha saiu da tela!")
	reset_ball()

func _process(_delta):
	if Input.is_action_just_pressed("click") or Input.is_action_just_pressed("d"):
		ball_node.launch()
