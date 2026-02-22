extends Node2D

@onready var ball_node: CharacterBody2D = $Ball
@onready var notifier: VisibleOnScreenNotifier2D = $Ball/VisibleOnScreenNotifier2D2
#@onready var bar1: BarMotion = $BarMotion1
#@onready var bar_grab1: BarMotion = $BarMotionGrab1
#@onready var bar_grab2: BarMotion = $BarMotionGrab2
var initial_ball_pos: Vector2
#var ball_ready_to_launch = true

func _ready():
	if not notifier.screen_exited.is_connected(_on_visible_on_screen_notifier_2d_screen_exited):
		notifier.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	
	initial_ball_pos = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 30)
	ball_node.position = initial_ball_pos
	print("LEVEL BASE")


func reset_ball_pos():
	ball_node.position = initial_ball_pos
	ball_node.reset()


func _on_visible_on_screen_notifier_2d_screen_exited():
	print("bolinha saiu da tela!")
	reset_ball_pos()
	$Ball.current_direction = Vector2(1, -1)
	#Global.ball_ready_to_launch = true


func _process(_delta):
	if Input.is_action_just_pressed("click") or Input.is_action_just_pressed("d"):
		#if Global.ball_ready_to_launch:
			ball_node.launch()
			#Global.ball_ready_to_launch = false
