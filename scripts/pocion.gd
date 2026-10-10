extends Area2D

@export var cantidad_curacion: int = 50

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("curar"):
		var se_curó: bool = body.curar(cantidad_curacion)
		if se_curó:
			queue_free()
