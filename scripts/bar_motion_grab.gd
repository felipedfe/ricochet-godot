#extends "res://scripts/bar_motion.gd"
#
#@onready var ball_node: Ball = $"../Ball"
#@onready var ball_col_shape: CollisionShape2D = $"../Ball/CollisionShape2D"
#@onready var col_shape: CollisionShape2D = $CollisionShape2D
#
## tamanho em pixels da faixa do topo e da base que NÃO gruda (só rebate)
#@export var edge_zone_px: float = 10.0
#
#var grab_offset := Vector2.ZERO
#var grab_offset_y := 0.0
#
#
#func _ready() -> void:
	#$BarSprite.modulate = Color.LIGHT_BLUE
	#setup(set_up_y_pos, set_down_y_pos)
	#set_speed(set_bar_speed)
	##print(global_position.y)
#
#
#func on_ball_hit(ball: Ball, collision: KinematicCollision2D) -> void:
	#
	## pega a "metade da altura" da colisão (extents.y) se for um retângulo
	#var rect := col_shape.shape as RectangleShape2D
	#var half_h = rect.extents.y
	#var half_w = rect.extents.x * global_scale.x
	#print("metades: ", rect.extents)
	##print(rect.extends.y + ball_node)
	#
	#var ball_rect := ball_col_shape.shape as CircleShape2D
	#var half_ball_w = ball_rect.radius * ball.global_scale.x
	#print(half_ball_w)
	#var offset_h = half_w + half_ball_w
#
	## y da bola relativo ao centro da barra (0 = meio, negativo = perto do topo, positivo = perto da base)
	#var local_y := ball.global_position.y - global_position.y
#
	## se está dentro da faixa de topo/base → rebate (não gruda)
	#var hit_top = local_y <= (-half_h + edge_zone_px)
	#var hit_bottom = local_y >= (half_h - edge_zone_px)
#
	#if hit_top or hit_bottom:
		## rebate como uma barra normal (usa o collision normal pra decidir eixo)
		## IMPORTANTE: não dá reset, senão ela para
		#ball.bounce(collision)
		#return
	#
	##if hit_top or hit_bottom:
		### Rebate como uma barra normal (usa o collision normal pra decidir eixo)
		### IMPORTANTE: não dá reset, senão ela para
		##ball.bounce(collision)
##
		### FORÇA o sentido vertical do ricochete:
		### topo -> sobe (y negativo), base -> desce (y positivo)
		##if hit_top:
			##ball.current_direction.y = -abs(ball.current_direction.y)
		##else:
			##ball.current_direction.y = abs(ball.current_direction.y)
##
		### trava em 45 graus (pra não virar um ângulo estranho)
		##ball.current_direction = ball.lock_to_45(ball.current_direction)
		##ball.direction = ball.current_direction
		##return
#
	#
	#
	#ball.reset()
	##print("current direction -> ", ball.current_direction)
#
	## define de que lado a bola veio. O segundo global position é o da barra
	#var from_left := ball.global_position.x < global_position.x
#
	## offset horizontal: se veio da esquerda, gruda à esquerda, senão à direita
	#var x_offset = -offset_h if from_left else offset_h # GAMBIARRA -> calcular esse número mágico
	#grab_offset.x = x_offset
#
	## guarda o offset vertical do ponto de colisão
	#grab_offset_y = ball.global_position.y - global_position.y
#
	## mantém ajuste de direção pra quando lançar
	##var normal = collision.get_normal()
	##ball.current_direction.x = normal.x
	#ball.current_direction.x = -1.0 if from_left else 1.0
	#ball.current_direction = ball.lock_to_45(ball.current_direction)
#
	#ball.grabed = true
	#ball.grabbed_by = self
	##Global.ball_ready_to_launch = trues
#
#
#func _process(_delta: float) -> void:
	#if ball_node.grabed and ball_node.grabbed_by == self:
#
		## mantém bola grudada lateralmente
		#ball_node.global_position.x = global_position.x + grab_offset.x
#
		## mantém bola na altura onde colidiu
		#ball_node.global_position.y = global_position.y + grab_offset_y
		#
		#ball_node.direction = Vector2.ZERO


#extends "res://scripts/bar_motion.gd"
#
#@onready var ball_node: Ball = $"../Ball"
#@onready var ball_col_shape: CollisionShape2D = $"../Ball/CollisionShape2D"
#@onready var col_shape: CollisionShape2D = $CollisionShape2D
#
## tamanho em pixels da faixa do topo e da base que não gruda (só rebate)
#@export var edge_zone_px: float = 10.0
#
#var grab_offset := Vector2.ZERO
#var grab_offset_y := 0.0
#
#
##func _ready() -> void:
	##$BarSprite.modulate = Color.LIGHT_BLUE
	##setup(BarMotion.Axis.VERTICAL, set_up_y_pos, set_down_y_pos)
	##set_speed(set_bar_speed)
	#
#func _ready() -> void:
	#super()
	#$BarSprite.modulate = Color.LIGHT_BLUE
#
#
#
#func on_ball_hit(ball: Ball, collision: KinematicCollision2D) -> void:
	#
	## pega a "metade da altura" da colisão (extents.y) se for um retângulo
	#var rect := col_shape.shape as RectangleShape2D
#
	## considera o scale do CollisionShape2D (evita inconsistência se o node pai estiver escalado)
	#var half_h = rect.extents.y * col_shape.global_scale.y
	#var half_w = rect.extents.x * col_shape.global_scale.x
	#print("metades: ", rect.extents)
	##print(rect.extends.y + ball_node)
	#
	#var ball_rect := ball_col_shape.shape as CircleShape2D
	#var half_ball_w = ball_rect.radius * ball.global_scale.x
	#print(half_ball_w)
	#var offset_h = half_w + half_ball_w
#
	## y da bola relativo ao centro da barra (0 = meio, negativo = perto do topo, positivo = perto da base)
	#var local_y := ball.global_position.y - global_position.y
#
	## para a faixa rosa também aumentar/diminuir com o scale:
	##var edge = edge_zone_px * col_shape.global_scale.y
	## para que a faixa rosa seja sempre 10px (ou outro valor setado em edge_zone_px) "de tela", não multiplica pelo scale:
	#var edge = edge_zone_px
#
	## se está dentro da faixa de topo/base → rebate (não gruda)
	#var hit_top = local_y <= (-half_h + edge)
	#var hit_bottom = local_y >= (half_h - edge)
#
	#if hit_top or hit_bottom:
		## rebate como uma barra normal (usa o collision normal pra decidir eixo)
		## IMPORTANTE: não dá reset, senão ela para
		#ball.bounce(collision)
		#return
	#
	#ball.reset()
#
	## define de que lado a bola veio. O segundo global position é o da barra
	#var from_left := ball.global_position.x < global_position.x
#
	## offset horizontal: se veio da esquerda, gruda à esquerda, senão à direita
	#var x_offset = -offset_h if from_left else offset_h # GAMBIARRA -> calcular esse número mágico
	#grab_offset.x = x_offset
#
	## guarda o offset vertical do ponto de colisão
	#grab_offset_y = ball.global_position.y - global_position.y
#
	## mantém ajuste de direção pra quando lançar
	##var normal = collision.get_normal()
	##ball.current_direction.x = normal.x
	#
	## ===========================================================================
	## ===========================================================================
	## ========= MANDA A BOLA CIMA OU PRA BAIXO DEPENDENDO DE ONDE ELA VEIO ======
	##ball.current_direction.x = -1.0 if from_left else 1.0
	##ball.current_direction = ball.lock_to_45(ball.current_direction)
	#
	## ========= MANDA A BOLA SEMPRE PRA CIMA ==================================
	#var x_dir := -1.0 if from_left else 1.0
	#ball.current_direction = Vector2(x_dir, -1.0)  # <- SEMPRE PRA CIMA
	#ball.current_direction = ball.lock_to_45(ball.current_direction)
	#
	## ===========================================================================
	## ==========================================================================
#
	#ball.grabed = true
	#ball.grabbed_by = self
	##Global.ball_ready_to_launch = trues
#
#
#func _process(_delta: float) -> void:
	#if ball_node.grabed and ball_node.grabbed_by == self:
#
		## mantém bola grudada lateralmente
		#ball_node.global_position.x = global_position.x + grab_offset.x
#
		## mantém bola na altura onde colidiu
		#ball_node.global_position.y = global_position.y + grab_offset_y
		#
		#ball_node.direction = Vector2.ZERO



#extends "res://scripts/bar_motion.gd"
#
#@onready var ball_node: Ball = $"../Ball"
#@onready var ball_col_shape: CollisionShape2D = $"../Ball/CollisionShape2D"
#@onready var col_shape: CollisionShape2D = $CollisionShape2D
#
## tamanho em pixels da faixa do topo e da base que não gruda (só rebate)
#@export var edge_zone_px: float = 10.0
#
#var grab_offset := Vector2.ZERO
#var grab_offset_y := 0.0
#
## controla se a colisão da bola deve ser desabilitada enquanto ela está grudada
## (isso evita "empurrões" e correções estranhas do motor físico que podem mexer na barra)
#var grabbed_collision_was_disabled := false
#
#
##func _ready() -> void:
	##$BarSprite.modulate = Color.LIGHT_BLUE
	##setup(BarMotion.Axis.VERTICAL, set_up_y_pos, set_down_y_pos)
	##set_speed(set_bar_speed)
#
#func _ready() -> void:
	#super()
	#$BarSprite.modulate = Color.LIGHT_BLUE
#
#
#func on_ball_hit(ball: Ball, collision: KinematicCollision2D) -> void:
#
	## pega a "metade da altura" da colisão (extents.y) se for um retângulo
	#var rect := col_shape.shape as RectangleShape2D
#
	## considera o scale do CollisionShape2D (evita inconsistência se o node pai estiver escalado)
	#var half_h = rect.extents.y * col_shape.global_scale.y
	#var half_w = rect.extents.x * col_shape.global_scale.x
	#print("metades: ", rect.extents)
	##print(rect.extends.y + ball_node)
#
	#var ball_rect := ball_col_shape.shape as CircleShape2D
	#var half_ball_w = ball_rect.radius * ball.global_scale.x
	#print(half_ball_w)
	#var offset_h = half_w + half_ball_w
#
	## y da bola relativo ao centro da barra (0 = meio, negativo = perto do topo, positivo = perto da base)
	#var local_y := ball.global_position.y - global_position.y
#
	## para a faixa rosa também aumentar/diminuir com o scale:
	##var edge = edge_zone_px * col_shape.global_scale.y
	## para que a faixa rosa seja sempre 10px (ou outro valor setado em edge_zone_px) "de tela", não multiplica pelo scale:
	#var edge = edge_zone_px
#
	## se está dentro da faixa de topo/base → rebate (não gruda)
	#var hit_top = local_y <= (-half_h + edge)
	#var hit_bottom = local_y >= (half_h - edge)
#
	#if hit_top or hit_bottom:
		## rebate como uma barra normal (usa o collision normal pra decidir eixo)
		## IMPORTANTE: não dá reset, senão ela para
		#ball.bounce(collision)
		#return
#
	#ball.reset()
#
	## define de que lado a bola veio. O segundo global position é o da barra
	#var from_left := ball.global_position.x < global_position.x
#
	## offset horizontal: se veio da esquerda, gruda à esquerda, senão à direita
	#var x_offset = -offset_h if from_left else offset_h # GAMBIARRA -> calcular esse número mágico
	#grab_offset.x = x_offset
#
	## guarda o offset vertical do ponto de colisão
	#grab_offset_y = ball.global_position.y - global_position.y
#
	## mantém ajuste de direção pra quando lançar
	##var normal = collision.get_normal()
	##ball.current_direction.x = normal.x
#
	## ===========================================================================
	## ===========================================================================
	## ========= MANDA A BOLA CIMA OU PRA BAIXO DEPENDENDO DE ONDE ELA VEIO ======
	##ball.current_direction.x = -1.0 if from_left else 1.0
	##ball.current_direction = ball.lock_to_45(ball.current_direction)
#
	## ========= MANDA A BOLA SEMPRE PRA CIMA ==================================
	#var x_dir := -1.0 if from_left else 1.0
	#ball.current_direction = Vector2(x_dir, -1.0)  # <- SEMPRE PRA CIMA
	#ball.current_direction = ball.lock_to_45(ball.current_direction)
#
	## ===========================================================================
	## ==========================================================================
#
	#ball.grabed = true
	#ball.grabbed_by = self
	##Global.ball_ready_to_launch = trues
#
	## enquanto estiver grudada, desabilita a colisão da bola pra evitar
	## correções físicas que podem "mexer" no objeto que ela está encostando.
	## (se sua bola for CharacterBody2D/RigidBody2D, isso ajuda MUITO.)
	#if is_instance_valid(ball_col_shape) and not ball_col_shape.disabled:
		#ball_col_shape.disabled = true
		#grabbed_collision_was_disabled = true
#
#
## IMPORTANTE:
## A bola estava sendo "colada" na barra em _process(), mas isso pode causar
## um frame de desencontro com a física (porque _process roda fora do step físico).
## Isso pode gerar empurrões/teleportes estranhos.
## Então aqui a gente faz a colagem no _physics_process, alinhado com a física.
#func _physics_process(_delta: float) -> void:
	## chama o movimento normal da barra (do BarMotion) primeiro
	#super(_delta)
#
	#if ball_node.grabed and ball_node.grabbed_by == self:
#
		## mantém bola grudada lateralmente
		#ball_node.global_position.x = global_position.x + grab_offset.x
#
		## mantém bola na altura onde colidiu
		#ball_node.global_position.y = global_position.y + grab_offset_y
#
		#ball_node.direction = Vector2.ZERO
#
	#else:
		## se a bola não está mais grudada nessa barra, reabilita a colisão (se a gente desabilitou antes)
		#if grabbed_collision_was_disabled and is_instance_valid(ball_col_shape):
			#ball_col_shape.disabled = false
			#grabbed_collision_was_disabled = false
#
#
##func _process(_delta: float) -> void:
	##if ball_node.grabed and ball_node.grabbed_by == self:
		### mantém bola grudada lateralmente
		##ball_node.global_position.x = global_position.x + grab_offset.x
		### mantém bola na altura onde colidiu
		##ball_node.global_position.y = global_position.y + grab_offset_y
		##ball_node.direction = Vector2.ZERO
		
		
extends "res://scripts/bar_motion.gd"

@onready var ball_node: Ball = $"../Ball"
@onready var ball_col_shape: CollisionShape2D = $"../Ball/CollisionShape2D"
@onready var col_shape: CollisionShape2D = $CollisionShape2D

# tamanho em pixels da faixa do topo e da base que não gruda (só rebate)
@export var edge_zone_px: float = 10.0

var grab_offset := Vector2.ZERO
var grab_offset_y := 0.0


func _ready() -> void:
	$BarSprite.modulate = Color.LIGHT_BLUE
	setup(BarMotion.Axis.VERTICAL, set_up_y_pos, set_down_y_pos)
	set_speed(set_bar_speed)
	#print(global_position.y)


func on_ball_hit(ball: Ball, collision: KinematicCollision2D) -> void:
	
	# pega a "metade da altura" da colisão (extents.y) se for um retângulo
	var rect := col_shape.shape as RectangleShape2D

	# considera o scale do CollisionShape2D (evita inconsistência se o node pai estiver escalado)
	var half_h = rect.extents.y * col_shape.global_scale.y
	var half_w = rect.extents.x * col_shape.global_scale.x
	print("metades: ", rect.extents)
	#print(rect.extends.y + ball_node)
	
	var ball_rect := ball_col_shape.shape as CircleShape2D
	var half_ball_w = ball_rect.radius * ball.global_scale.x
	print(half_ball_w)
	var offset_h = half_w + half_ball_w

	# y da bola relativo ao centro da barra (0 = meio, negativo = perto do topo, positivo = perto da base)
	var local_y := ball.global_position.y - global_position.y

	# para a faixa rosa também aumentar/diminuir com o scale:
	#var edge = edge_zone_px * col_shape.global_scale.y
	# para que a faixa rosa seja sempre 10px (ou outro valor setado em edge_zone_px) "de tela", não multiplica pelo scale:
	var edge = edge_zone_px

	# se está dentro da faixa de topo/base → rebate (não gruda)
	var hit_top = local_y <= (-half_h + edge)
	var hit_bottom = local_y >= (half_h - edge)

	if hit_top or hit_bottom:
		# rebate como uma barra normal (usa o collision normal pra decidir eixo)
		# IMPORTANTE: não dá reset, senão ela para
		ball.bounce(collision)
		return
	
	ball.reset()

	# define de que lado a bola veio. O segundo global position é o da barra
	var from_left := ball.global_position.x < global_position.x

	# offset horizontal: se veio da esquerda, gruda à esquerda, senão à direita
	var x_offset = -offset_h if from_left else offset_h # GAMBIARRA -> calcular esse número mágico
	grab_offset.x = x_offset

	# guarda o offset vertical do ponto de colisão
	grab_offset_y = ball.global_position.y - global_position.y

# ===========================================================================
	# ===========================================================================
	# ========= MANDA A BOLA CIMA OU PRA BAIXO DEPENDENDO DE ONDE ELA VEIO ======
	#ball.current_direction.x = -1.0 if from_left else 1.0
	#ball.current_direction = ball.lock_to_45(ball.current_direction)

	# ========= MANDA A BOLA SEMPRE PRA CIMA ==================================
	var x_dir := -1.0 if from_left else 1.0
	ball.current_direction = Vector2(x_dir, -1.0)  # <- SEMPRE PRA CIMA
	ball.current_direction = ball.lock_to_45(ball.current_direction)

	# ===========================================================================
	# ==========================================================================

	ball.grabed = true
	ball.grabbed_by = self
	#Global.ball_ready_to_launch = trues


func _process(_delta: float) -> void:
	if ball_node.grabed and ball_node.grabbed_by == self:

		# mantém bola grudada lateralmente
		ball_node.global_position.x = global_position.x + grab_offset.x

		# mantém bola na altura onde colidiu
		ball_node.global_position.y = global_position.y + grab_offset_y
		
		ball_node.direction = Vector2.ZERO
