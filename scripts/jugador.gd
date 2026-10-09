extends CharacterBody2D

@export var velocidad: float = 200.0
@export var vida_maxima: int = 100

var vida_actual: int
@export var escena_bala: PackedScene

@export var zoom_normal: Vector2 = Vector2(1.4,1.4)
@export var zoom_combate: Vector2 = Vector2(0.9,0.9)
@export var velocidad_zoom: float = 4.0
@export var distancia_deteccion_combate: float = 350.0

@onready var mira: Marker2D = $mira
@onready var barra_vida: ProgressBar = $vida
@onready var camara: Camera2D = $Camera2D


func _ready() -> void:
	vida_actual = vida_maxima
	if barra_vida:
		barra_vida.max_value = vida_maxima
		barra_vida.value = vida_actual

func _physics_process(_delta: float) -> void:
	
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * velocidad
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	
	if Input.is_action_just_pressed("disparar"):
		disparar()
	
	actualizar_zoom_camara(_delta)

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

func actualizar_zoom_camara(delta:float) -> void:
	if not camara:
		return
	
	var hay_enemigo_cerca: bool = comprobar_enemigos_cercanos()
	var zoom_objetivo: Vector2 = zoom_combate if hay_enemigo_cerca else zoom_normal
	camara.zoom = camara.zoom.lerp(zoom_objetivo, velocidad_zoom * delta)

func comprobar_enemigos_cercanos() -> bool:
	var nodos = get_tree().get_nodes_in_group("enemigo")
	
	if nodos is Array:
		for enemigo in nodos:
			if is_instance_valid(enemigo) and enemigo is Node2D:
				var distancia = global_position.distance_to(enemigo.global_position)
				if distancia <= distancia_deteccion_combate:
					return true
	return false
