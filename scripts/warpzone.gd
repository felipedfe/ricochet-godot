#extends Node2D
#class_name WarpZone
#
#@export var cooldown := 0.2
#@export var exit_offset := Vector2(0, -1)
#
#@onready var warpA: WarpPortal = $WarpA
#@onready var warpB: Node2D = $WarpB
#
#var is_cooldown := false
#
#func _ready() -> void:
	#warpA.ball_entered.connect(_on_ball_entered)
#
#func _on_ball_entered(ball: Node2D) -> void:
	#if is_cooldown:
		#return
#
	#is_cooldown = true
#
	## bola desaparece
	#ball.visible = false
#
	#await get_tree().create_timer(cooldown).timeout
#
	## reaparece no ponto de saída
	#ball.global_position = warpB.global_position + exit_offset
	#ball.visible = true
	#ball.launch()
#
	#is_cooldown = false
	
	
	
	
	
	
	
	
	
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

	var b := ball as Ball
	if b == null:
		return

	is_cooldown = true

	# --- guarda a direção EXATA antes de entrar ---
	var saved_dir: Vector2 = b.direction
	if saved_dir == Vector2.ZERO:
		# fallback: se por algum motivo direction estiver zero, usa current_direction
		saved_dir = b.current_direction
	# garante que não vai ser zero
	if saved_dir == Vector2.ZERO:
		saved_dir = Vector2(1, -1)

	# bola desaparece
	b.visible = false

	await get_tree().create_timer(cooldown).timeout

	# reaparece no ponto de saída
	b.global_position = warpB.global_position + exit_offset
	b.visible = true

	# --- restaura a mesma direção X e Y ---
	b.current_direction = saved_dir.normalized()
	b.direction = b.current_direction

	# empurra um pouquinho pra fora na direção do movimento (evita colidir no mesmo frame)
	b.global_position += b.current_direction * (b.ball_radius + 2.0)

	# relança mantendo a direção
	b.launch()

	is_cooldown = false
