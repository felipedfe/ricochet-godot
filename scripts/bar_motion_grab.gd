extends "res://scripts/bar_motion.gd"


var ball_local:Ball

func _ready() -> void:
	$BarSprite.modulate = Color.LIGHT_BLUE

func on_ball_hit(ball: Ball, collision: KinematicCollision2D) -> void:
	ball_local = ball
	ball.reset()

	# cola no ponto de contato (um tiquinho pra fora pra não ficar “dentro”)
	var normal = collision.get_normal()
	#var collision_x = collision.get_position().x
	#ball.global_position = collision.get_position() + normal * ball.ball_radius # GAMBIARRA consertar depois, esse valor tem que ser dinâmico em relação ao tamanho da bola
	ball.global_position = collision.get_position() + normal * (ball.ball_radius - 13) # GAMBIARRA consertar depois, esse valor tem que ser dinâmico em relação ao tamanho da bola
	#print(typeof(collision_x))
	#print(normal)
	ball.current_direction.x = normal.x
	#ball.direction = Vector2(-1, -1)
	
	Global.ball_ready_to_launch = true
	print(ball_local.position + Vector2(200,200))

func _process(_delta: float) -> void:
	if ball_local:
		ball_local.position = position - Vector2(40,40) # GAMBIARRA calcular esse valor depois
		print(Global.ball_ready_to_launch)
	#pass
