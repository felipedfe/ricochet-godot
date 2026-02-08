extends Node2D
class_name WarpZone

@export var cooldown := 0.2
@export var exit_offset := Vector2(0, -1)

@onready var warpA: WarpPortal = $WarpA
@onready var warpB: Node2D = $WarpB

var is_cooldown := false

func _ready() -> void:
	warpA.ball_entered.connect(_on_ball_entered)

func _on_ball_entered(ball: Node2D) -> void:
	if is_cooldown:
		return

	is_cooldown = true

	# bola desaparece
	ball.visible = false

	await get_tree().create_timer(cooldown).timeout

	# reaparece no ponto de saída
	ball.global_position = warpB.global_position + exit_offset
	ball.visible = true
	ball.launch()

	is_cooldown = false
