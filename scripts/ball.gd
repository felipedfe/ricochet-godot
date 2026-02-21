extends CharacterBody2D
class_name Ball

@export var speed: float = 1500.0
#@export var separation_push: float = 1.0 # empurra pra fora após colisão (ajuste fino)
var direction: Vector2 = Vector2.ZERO
var current_direction: Vector2 = Vector2(1, -1)
var ball_radius: float
var grabed: bool = false
var grabbed_by: Node = null

func _ready() -> void:
	#direction = Vector2.ZERO
	$BallSprite.modulate = Color.HOT_PINK
	ball_radius = $CollisionShape2D.shape.radius
	#print(ball_radius)

func launch() -> void:
	# (1, -1) = pra direita e pra cima
	#direction = Vector2(1, -1).normalized()
	direction = current_direction.normalized()
	grabed = false
	grabbed_by = null

func reset() -> void:
	direction = Vector2.ZERO

#func reflects_direction(collision):
	#var normal = collision.get_normal()
	#direction = Vector2(-1, -1).normalized()
	#global_position += normal * 10.0
	#print(collision)

#func bounce(collision:KinematicCollision2D):
	##print(collision.get_collider())
	#
	## esse normal é o vetor da direção oposta ao objeto de colisão
	## ex: se a bola bate no chão o normal retornado seria Vector2(0, -1), que seria a direção pra cima
	#var normal = collision.get_normal() 
	## reflete direção
	#current_direction = direction.bounce(normal).normalized()
#
	#direction = current_direction
	## empurra a bola um pouquinho pra fora da barra, isso é pra evitar que bola agarre na barra
	#global_position += normal * 10.0
	
func lock_to_45(v: Vector2) -> Vector2:
	var sx := 1.0 if v.x >= 0.0 else -1.0
	var sy := 1.0 if v.y >= 0.0 else -1.0
	return Vector2(sx, sy).normalized()

func bounce(collision: KinematicCollision2D):
	# esse normal é o vetor da direção oposta ao objeto de colisão
	# ex: se a bola bate no chão o normal retornado seria Vector2(0, -1), que seria a direção pra cima
	var normal = collision.get_normal()

	# decide se inverte X ou Y (sem de ângulo livre)
	if abs(normal.x) > abs(normal.y):
		current_direction.x *= -1
	else:
		current_direction.y *= -1

	# trava sempre em 45 graus
	current_direction = lock_to_45(current_direction)
	direction = current_direction

	# empurra a bola um pouquinho pra fora da barra, isso é pra evitar que bola agarre na barra
	global_position += normal * 10.0


func _physics_process(delta):
	if direction != Vector2.ZERO:
		var motion = direction * speed * delta
		var collision = move_and_collide(motion)

		if collision:
			var collider = collision.get_collider()

			# Se o collider tiver um método pra tratar a colisão ele chama, senao cai no bounce()
			if collider != null and collider.has_method("on_ball_hit"):
				collider.on_ball_hit(self, collision)
				return
			
			bounce(collision)
