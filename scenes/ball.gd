extends CharacterBody2D

@export var speed := 800.0
var direction := Vector2.ZERO
var motion: Vector2

func _ready():
	direction = Vector2.ZERO

func launch():
	direction = Vector2(1, -1).normalized()

func reset():
	direction = Vector2.ZERO
	motion = Vector2.ZERO

func _physics_process(delta):
	if direction != Vector2.ZERO:
		motion = direction * speed * delta
		var collision = move_and_collide(motion)

		if collision:
			direction = direction.bounce(collision.get_normal())
				
