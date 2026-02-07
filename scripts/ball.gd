#extends CharacterBody2D
#
#@export var speed := 1500
#var direction := Vector2.ZERO
#var motion: Vector2
#
#func _ready():
	#direction = Vector2.ZERO
	#$BallSprite.modulate = Color.HOT_PINK # para pintar a bola
#
#func launch():
	## (1, -1) = pra direita e pra cima
	#direction = Vector2(1, -1).normalized() # normalized é pra deixar a velocidade diagonal não muito rápida
#
#func reset():
	#direction = Vector2.ZERO
	#motion = Vector2.ZERO
#
#func _physics_process(delta):
	#if direction != Vector2.ZERO:
		#motion = direction * speed * delta
		#var collision = move_and_collide(motion)
#
		#if collision:
			#direction = direction.bounce(collision.get_normal())
				#

extends CharacterBody2D

@export var speed: float = 1500.0
@export var separation_push: float = 1.0 # empurra pra fora após colisão (ajuste fino)

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	direction = Vector2.ZERO
	$BallSprite.modulate = Color.HOT_PINK

func launch() -> void:
	# (1, -1) = pra direita e pra cima
	direction = Vector2(1, -1).normalized()

func reset() -> void:
	direction = Vector2.ZERO

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var motion = direction * speed * delta
		var collision = move_and_collide(motion)

		if collision:
			var normal = collision.get_normal()

			# Reflete direção
			direction = direction.bounce(normal).normalized()

			# Empurra a bola um pouquinho pra fora da barra
			global_position += normal * 10.0
