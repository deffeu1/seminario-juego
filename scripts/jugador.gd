extends CharacterBody2D

@export var velocidad: float = 200.0
@export var vida_maxima: int = 100
var vida_actual: int

@export var escena_bala: PackedScene

@onready var mira: Marker2D = $mira
@onready var barra_vida: ProgressBar = $vida

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
