extends AnimatableBody2D
class_name BarMotion


@export var set_up_y_pos: float = 0
@export var set_down_y_pos: float = 0
@export var set_bar_speed: float = 0

var initial_y_pos: float
var final_y_pos: float
var speed = 0 # padrão é 200
var dir: float = -1.0 # -1 = subindo, +1 = descendo

func _ready():
	setup(set_up_y_pos, set_down_y_pos)
	set_speed(set_bar_speed)

# define até onde a barra pode subir e descer
func setup(up_y_pos: float, down_y_pos: float):
	initial_y_pos = position.y - up_y_pos
	final_y_pos = position.y + down_y_pos
	
	dir = 1.0

func set_speed(bar_speed: float):
	speed = bar_speed

func _physics_process(delta: float) -> void:
	position.y += dir * speed * delta

	if position.y <= initial_y_pos:
		dir = 1.0

	elif position.y >= final_y_pos:
		dir = -1.0
