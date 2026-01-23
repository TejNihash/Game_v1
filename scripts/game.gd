extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_tree().get_nodes_in_group("EnemiesGroup"))
	for enemy in get_tree().get_nodes_in_group("EnemiesGroup"):
		enemy.died.connect(_on_died)

func _on_died() -> void:
	print(get_tree().get_nodes_in_group("EnemiesGroup").size()-1," left")

	if get_tree().get_nodes_in_group("EnemiesGroup").size()<=1:
		print("ALL ENEMIES DEAD 🎉")
		%GameOver.visible = true
		await get_tree().create_timer(3.0).timeout
		get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
