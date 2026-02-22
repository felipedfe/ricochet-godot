#extends AnimatableBody2D
#class_name BarMotion
#
#
#@export var set_up_y_pos: float = 0
#@export var set_down_y_pos: float = 0
#@export var set_bar_speed: float = 0
#
#var initial_y_pos: float
#var final_y_pos: float
#var speed = 0 # padrão é 200
#var dir: float = -1.0 # -1 = subindo, +1 = descendo
#
#func _ready():
	#setup(set_up_y_pos, set_down_y_pos)
	#set_speed(set_bar_speed)
#
## define até onde a barra pode subir e descer
#func setup(up_y_pos: float, down_y_pos: float):
	#initial_y_pos = position.y - up_y_pos
	#final_y_pos = position.y + down_y_pos
	#
	#dir = 1.0
#
#func set_speed(bar_speed: float):
	#speed = bar_speed
#
#func _physics_process(delta: float) -> void:
	#position.y += dir * speed * delta
#
	#if position.y <= initial_y_pos:
		#dir = 1.0
#
	#elif position.y >= final_y_pos:
		#dir = -1.0


extends AnimatableBody2D
class_name BarMotion

enum Axis { VERTICAL, HORIZONTAL }

@export var axis: Axis = Axis.VERTICAL

# distância de ida e volta (serve pra Y ou X dependendo do axis)
@export var set_up_y_pos: float = 0      # (se axis for VERTICAL)
@export var set_down_y_pos: float = 0    # (se axis for VERTICAL)

@export var set_left_x_pos: float = 0    # (se axis for HORIZONTAL)
@export var set_right_x_pos: float = 0   # (se axis for HORIZONTAL)

@export var set_bar_speed: float = 0

var initial_pos: float
var final_pos: float
var speed := 0.0 # padrão é 200
var dir := 1.0   # -1 volta, +1 vai


func _ready():
	_apply_limits()
	set_speed(set_bar_speed)


func _apply_limits() -> void:
	if axis == Axis.VERTICAL:
		# define até onde a barra pode subir e descer
		initial_pos = position.y - set_up_y_pos
		final_pos = position.y + set_down_y_pos
	else:
		# define até onde a barra pode ir para esquerda e direita
		initial_pos = position.x - set_left_x_pos
		final_pos = position.x + set_right_x_pos

	dir = 1.0


func setup(_axis: Axis, a: float, b: float) -> void:
	# a e b viram (up/down) ou (left/right), dependendo do eixo
	axis = _axis
	if axis == Axis.VERTICAL:
		set_up_y_pos = a
		set_down_y_pos = b
	else:
		set_left_x_pos = a
		set_right_x_pos = b

	_apply_limits()


func set_speed(bar_speed: float) -> void:
	speed = bar_speed


func _physics_process(delta: float) -> void:
	if axis == Axis.VERTICAL:
		position.y += dir * speed * delta

		if position.y <= initial_pos:
			dir = 1.0
		elif position.y >= final_pos:
			dir = -1.0
	else:
		position.x += dir * speed * delta

		if position.x <= initial_pos:
			dir = 1.0
		elif position.x >= final_pos:
			dir = -1.0
