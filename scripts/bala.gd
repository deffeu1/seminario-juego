extends Area2D

@export var velocidad: float = 600.0
@export var dano: int = 25
var direccion: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += direccion * velocidad * delta

func _on_body_entered(body: Node2D) -> void:
	
	if body.has_method("recibir_dano"):
		body.recibir_dano(dano)
	queue_free()
