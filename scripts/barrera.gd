extends StaticBody2D

@export var vida_maxima: int = 50
var vida_actual: int

func _ready() -> void:
	vida_actual = vida_maxima

func recibir_dano(cantidad: int) -> void:
	vida_actual -= cantidad
	
	modulate = Color(1, 0.5, 0.5) 
	
	if vida_actual <= 0:
		destruir_barrera()

func destruir_barrera() -> void:
	queue_free()
