extends Node2D

@onready var ball_node: CharacterBody2D = $Ball
@onready var bar1: BarMotion = $BarMotion1
@onready var bar_grab1: BarMotion = $BarMotionGrab1
@onready var bar_grab2: BarMotion = $BarMotionGrab2
var initial_ball_pos: Vector2
#var ball_ready_to_launch = true

func _ready():
	initial_ball_pos = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 30)
	ball_node.position = initial_ball_pos
	bar1.setup(50,200)
	bar1.set_speed(200)
	bar_grab1.setup(100, 140)
	bar_grab1.set_speed(200)
	bar_grab2.setup(100, 120)
	bar_grab2.set_speed(50)
func reset_ball_pos():
	ball_node.position = initial_ball_pos
	ball_node.reset()

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("bolinha saiu da tela!")
	reset_ball_pos()
	$Ball.current_direction = Vector2(1, -1)
	Global.ball_ready_to_launch = true

func _process(_delta):
	if Input.is_action_just_pressed("click") or Input.is_action_just_pressed("d"):
		if Global.ball_ready_to_launch:
			ball_node.launch()
			Global.ball_ready_to_launch = false
