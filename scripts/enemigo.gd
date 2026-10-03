extends CharacterBody2D

@export var vida_maxima: int = 100
var vida_actual: int

@export var escena_bala: PackedScene
var jugador: Node2D = null

@onready var raycast: RayCast2D = $RayCast2D
@onready var mira: Marker2D = $mira
@onready var barra_vida: ProgressBar = $vida

func _ready() -> void:
	vida_actual = vida_maxima
	if barra_vida:
		barra_vida.max_value = vida_maxima
		barra_vida.value = vida_actual
		
		
	var jugadores = get_tree().get_nodes_in_group("jugador")
	if jugadores.size() > 0:
		jugador = jugadores[0]

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(jugador):
		return

	look_at(jugador.global_position)
	
	raycast.target_position = raycast.to_local(jugador.global_position)

func _on_cadencia_timer_timeout() -> void:
	if not is_instance_valid(jugador):
		return

	if raycast.is_colliding():
		var colision = raycast.get_collider()
		if colision == jugador:
			disparar()

func disparar() -> void:
	if escena_bala:
		var bala = escena_bala.instantiate()
		
		get_tree().current_scene.add_child(bala)
		
		bala.global_position = mira.global_position
		bala.global_rotation = global_rotation
		bala.direccion = Vector2.RIGHT.rotated(global_rotation)

func recibir_dano(cantidad: int) -> void:
	vida_actual -= cantidad
	if barra_vida:
		barra_vida.value = vida_actual
	if vida_actual <= 0:
		queue_free()
