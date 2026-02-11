extends "res://scripts/bar_motion.gd"


@onready var ball_node:Ball = $"../Ball"

func _ready() -> void:
	$BarSprite.modulate = Color.LIGHT_BLUE

func on_ball_hit(ball: Ball, collision: KinematicCollision2D) -> void:
	#ball_node = ball
	ball.reset()

	var normal = collision.get_normal()
	#var collision_x = collision.get_position().x
	#ball.global_position = collision.get_position() + normal * ball.ball_radius # GAMBIARRA consertar depois, esse valor tem que ser dinâmico em relação ao tamanho da bola
	ball.global_position = collision.get_position() + normal * (ball.ball_radius - 13) # GAMBIARRA consertar depois, esse valor tem que ser dinâmico em relação ao tamanho da bola
	#print(typeof(collision_x))
	#print(normal)
	# lembre-se que "normal" retorna a direção refletida
	ball.current_direction.x = normal.x
	#ball.direction = Vector2(-1, -1)
	
	ball.grabed = true
	ball.grabbed_by = self
	Global.ball_ready_to_launch = true
	print(ball_node.position + Vector2(200,200))

func _process(_delta: float) -> void:
	if ball_node.grabed and ball_node.grabbed_by == self:
		ball_node.position = position - Vector2(40,40) # GAMBIARRA calcular esse valor depois
		#print(Global.ball_ready_to_launch)
		ball_node.direction = Vector2.ZERO
		
		#if ball_node.grabed:
			#ball_node.direction = Vector2.ZERO
			#print(ball_node.current_direction)
	
