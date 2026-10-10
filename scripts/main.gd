extends Node2D

@export var escena_victoria: PackedScene

func _process(_delta: float) -> void:
	comprobar_victoria()

func comprobar_victoria() -> void:
	var enemigos = get_tree().get_nodes_in_group("enemigo")
	
	if enemigos.size() == 0:
		get_tree().change_scene_to_file("res://escenas/win.tscn")
