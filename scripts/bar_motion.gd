#extends AnimatableBody2D
#class_name BarMotion
#
#enum Axis { VERTICAL, HORIZONTAL }
#
#@export var axis: Axis = Axis.VERTICAL
#
## distância de ida e volta (serve pra Y ou X dependendo do axis)
#@export var set_up_y_pos: float = 0      # (se axis for VERTICAL)
#@export var set_down_y_pos: float = 0    # (se axis for VERTICAL)
#
#@export var set_left_x_pos: float = 0    # (se axis for HORIZONTAL)
#@export var set_right_x_pos: float = 0   # (se axis for HORIZONTAL)
#
#@export var set_bar_speed: float = 0
#
#var initial_pos: float
#var final_pos: float
#var speed := 0.0 # padrão é 200
#var dir := 1.0   # -1 volta, +1 vai
#
#
#func _ready():
	#_apply_limits()
	#set_speed(set_bar_speed)
#
#
#func _apply_limits() -> void:
	#if axis == Axis.VERTICAL:
		## define até onde a barra pode subir e descer
		#initial_pos = position.y - set_up_y_pos
		#final_pos = position.y + set_down_y_pos
	#else:
		## define até onde a barra pode ir para esquerda e direita
		#initial_pos = position.x - set_left_x_pos
		#final_pos = position.x + set_right_x_pos
#
	#dir = 1.0
#
#
#func setup(_axis: Axis, a: float, b: float) -> void:
	## a e b viram (up/down) ou (left/right), dependendo do eixo
	#axis = _axis
	#if axis == Axis.VERTICAL:
		#set_up_y_pos = a
		#set_down_y_pos = b
	#else:
		#set_left_x_pos = a
		#set_right_x_pos = b
#
	#_apply_limits()
#
#
#func set_speed(bar_speed: float) -> void:
	#speed = bar_speed
#
#
#func _physics_process(delta: float) -> void:
	#if axis == Axis.VERTICAL:
		#position.y += dir * speed * delta
#
		#if position.y <= initial_pos:
			#dir = 1.0
		#elif position.y >= final_pos:
			#dir = -1.0
#
	#else:
		#position.x += dir * speed * delta
#
		#if position.x <= initial_pos:
			#dir = 1.0
		#elif position.x >= final_pos:
			#dir = -1.0


#extends CharacterBody2D
#class_name BarMotion
#
#enum Axis { VERTICAL, HORIZONTAL }
#@export var axis: Axis = Axis.HORIZONTAL
#
#@export var set_up_y_pos: float = 0
#@export var set_down_y_pos: float = 0
#@export var set_left_x_pos: float = 0
#@export var set_right_x_pos: float = 0
#@export var speed: float = 150.0
#
#var start_pos: Vector2
#var min_pos: float
#var max_pos: float
#var dir := 1.0
#
#func _ready() -> void:
	#start_pos = global_position
	#_apply_limits()
#
#func _apply_limits() -> void:
	#if axis == Axis.VERTICAL:
		#min_pos = start_pos.y - set_up_y_pos
		#max_pos = start_pos.y + set_down_y_pos
	#else:
		#min_pos = start_pos.x - set_left_x_pos
		#max_pos = start_pos.x + set_right_x_pos
#
	#if min_pos > max_pos:
		#var t = min_pos
		#min_pos = max_pos
		#max_pos = t
#
	#dir = 1.0
#
#func _physics_process(_delta: float) -> void:
	#var v := Vector2.ZERO
#
	#if axis == Axis.VERTICAL:
		#v.y = dir * speed
	#else:
		#v.x = dir * speed
#
	#velocity = v
	#move_and_slide()
#
	## checa e “gruda” no limite pra não ter overshoot
	#if axis == Axis.VERTICAL:
		#if global_position.y <= min_pos:
			#global_position.y = min_pos
			#dir = 1.0
		#elif global_position.y >= max_pos:
			#global_position.y = max_pos
			#dir = -1.0
	#else:
		#if global_position.x <= min_pos:
			#global_position.x = min_pos
			#dir = 1.0
		#elif global_position.x >= max_pos:
			#global_position.x = max_pos
			#dir = -1.0


#extends AnimatableBody2D
#class_name BarMotion
#
#enum Axis { VERTICAL, HORIZONTAL }
#@export var axis: Axis = Axis.HORIZONTAL
#
#@export var set_up_y_pos: float = 0
#@export var set_down_y_pos: float = 0
#@export var set_left_x_pos: float = 0
#@export var set_right_x_pos: float = 0
#@export var speed: float = 150.0
#
#var start_pos: Vector2
#var min_pos: float
#var max_pos: float
#var dir := 1.0
#
#func _ready() -> void:
	#start_pos = global_position
	#_apply_limits()
#
#func _apply_limits() -> void:
	#if axis == Axis.VERTICAL:
		#min_pos = start_pos.y - set_up_y_pos
		#max_pos = start_pos.y + set_down_y_pos
	#else:
		#min_pos = start_pos.x - set_left_x_pos
		#max_pos = start_pos.x + set_right_x_pos
#
	#if min_pos > max_pos:
		#var t = min_pos
		#min_pos = max_pos
		#max_pos = t
#
	#dir = 1.0
#
#func _physics_process(delta: float) -> void:
	## AnimatableBody2D: move manualmente (sem velocity / move_and_slide),
	## assim a barra não "escorrega" lateralmente por resolução de colisão.
	#var step := dir * speed * delta
#
	#if axis == Axis.VERTICAL:
		#global_position.y += step
#
		## checa e “gruda” no limite pra não ter overshoot
		#if global_position.y <= min_pos:
			#global_position.y = min_pos
			#dir = 1.0
		#elif global_position.y >= max_pos:
			#global_position.y = max_pos
			#dir = -1.0
	#else:
		#global_position.x += step
#
		## checa e “gruda” no limite pra não ter overshoot
		#if global_position.x <= min_pos:
			#global_position.x = min_pos
			#dir = 1.0
		#elif global_position.x >= max_pos:
			#global_position.x = max_pos
			#dir = -1.0


#extends AnimatableBody2D
#class_name BarMotion
#
#enum Axis { VERTICAL, HORIZONTAL }
#
#@export var axis: Axis = Axis.VERTICAL
#
## distância de ida e volta (serve pra Y ou X dependendo do axis)
#@export var set_up_y_pos: float = 0      # (se axis for VERTICAL)
#@export var set_down_y_pos: float = 0    # (se axis for VERTICAL)
#
#@export var set_left_x_pos: float = 0    # (se axis for HORIZONTAL)
#@export var set_right_x_pos: float = 0   # (se axis for HORIZONTAL)
#
#@export var set_bar_speed: float = 0
#
#var initial_pos: float
#var final_pos: float
#var speed := 0.0 # padrão é 200
#var dir := 1.0   # -1 volta, +1 vai
#
#
#func _ready():
	#_apply_limits()
	#set_speed(set_bar_speed)
#
#
#func _apply_limits() -> void:
	#if axis == Axis.VERTICAL:
		## define até onde a barra pode subir e descer
		#initial_pos = position.y - set_up_y_pos
		#final_pos = position.y + set_down_y_pos
	#else:
		## define até onde a barra pode ir para esquerda e direita
		#initial_pos = position.x - set_left_x_pos
		#final_pos = position.x + set_right_x_pos
#
	#dir = 1.0
#
#
#func setup(_axis: Axis, a: float, b: float) -> void:
	## a e b viram (up/down) ou (left/right), dependendo do eixo
	#axis = _axis
	#if axis == Axis.VERTICAL:
		#set_up_y_pos = a
		#set_down_y_pos = b
	#else:
		#set_left_x_pos = a
		#set_right_x_pos = b
#
	#_apply_limits()
#
#
#func set_speed(bar_speed: float) -> void:
	#speed = bar_speed
#
#
#func _physics_process(delta: float) -> void:
	#if axis == Axis.VERTICAL:
		#position.y += dir * speed * delta
#
		#if position.y <= initial_pos:
			#dir = 1.0
		#elif position.y >= final_pos:
			#dir = -1.0
	#else:
		#position.x += dir * speed * delta
#
		#if position.x <= initial_pos:
			#dir = 1.0
		#elif position.x >= final_pos:
			#dir = -1.0




#extends AnimatableBody2D
#class_name BarMotion
#
#enum Axis { VERTICAL, HORIZONTAL }
#
#@export var axis: Axis = Axis.VERTICAL
#
## distância de ida e volta (serve pra Y ou X dependendo do axis)
#@export var set_up_y_pos: float = 0      # (se axis for VERTICAL)
#@export var set_down_y_pos: float = 0    # (se axis for VERTICAL)
#
#@export var set_left_x_pos: float = 0    # (se axis for HORIZONTAL)
#@export var set_right_x_pos: float = 0   # (se axis for HORIZONTAL)
#
#@export var set_bar_speed: float = 0
#
#var initial_pos: float
#var final_pos: float
#var speed := 0.0 # padrão é 200
#var dir := 1.0   # -1 volta, +1 vai
#
#
#func _ready():
	#_apply_limits()
	#set_speed(set_bar_speed)
#
#
#func _apply_limits() -> void:
	#if axis == Axis.VERTICAL:
		## define até onde a barra pode subir e descer
		#initial_pos = position.y - set_up_y_pos
		#final_pos = position.y + set_down_y_pos
	#else:
		## define até onde a barra pode ir para esquerda e direita
		#initial_pos = position.x - set_left_x_pos
		#final_pos = position.x + set_right_x_pos
#
	#dir = 1.0
#
#
#func setup(_axis: Axis, a: float, b: float) -> void:
	## a e b viram (up/down) ou (left/right), dependendo do eixo
	#axis = _axis
	#if axis == Axis.VERTICAL:
		#set_up_y_pos = a
		#set_down_y_pos = b
	#else:
		#set_left_x_pos = a
		#set_right_x_pos = b
#
	#_apply_limits()
#
#
#func set_speed(bar_speed: float) -> void:
	#speed = bar_speed
#
#
#func _physics_process(delta: float) -> void:
	#if axis == Axis.VERTICAL:
		#position.y += dir * speed * delta
#
		#if position.y <= initial_pos:
			#dir = 1.0
		#elif position.y >= final_pos:
			#dir = -1.0
	#else:
		#position.x += dir * speed * delta
#
		#if position.x <= initial_pos:
			#dir = 1.0
		#elif position.x >= final_pos:
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

@export var set_bar_speed: float = 150.0

# Se você quiser propositalmente desencontrar barras, dá um offset aqui (em segundos).
# Pra sincronizar, deixa 0 nas duas.
@export var phase_offset_sec: float = 0.0

@export var ease_power: float = 1.0

var initial_pos: float
var final_pos: float
var mid_pos: float
var amp: float

# “relógio” local: frame em que a barra começou a existir
var start_frame: int = 0


func _ready() -> void:
	start_frame = Engine.get_physics_frames()
	_apply_limits()


func _apply_limits() -> void:
	if axis == Axis.VERTICAL:
		# define até onde a barra pode subir e descer
		initial_pos = position.y - set_up_y_pos
		final_pos = position.y + set_down_y_pos
	else:
		# define até onde a barra pode ir para esquerda e direita
		initial_pos = position.x - set_left_x_pos
		final_pos = position.x + set_right_x_pos

	# garante ordem correta
	if initial_pos > final_pos:
		var t = initial_pos
		initial_pos = final_pos
		final_pos = t

	# centro e amplitude do movimento
	mid_pos = (initial_pos + final_pos) * 0.5
	amp = (final_pos - initial_pos) * 0.5


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
	set_bar_speed = bar_speed


func _physics_process(_delta: float) -> void:
	# se não tem amplitude ou velocidade, não move
	if amp <= 0.0 or set_bar_speed <= 0.0:
		return

	# tempo absoluto baseado em ticks da física (não acumula erro)
	var frames := Engine.get_physics_frames() - start_frame
	var t := float(frames) / float(Engine.physics_ticks_per_second) + phase_offset_sec

	# Movimento determinístico: seno vai de -1..1
	# Queremos que a velocidade média fique proporcional ao set_bar_speed.
	# Distância por ciclo (vai e volta) em seno ~ 4*amp (aproxima bem pro seu caso)
	var period := (4.0 * amp) / set_bar_speed
	var omega := TAU / period

	var pos := mid_pos + sin(t * omega) * amp

	if axis == Axis.VERTICAL:
		position.y = pos
	else:
		position.x = pos
