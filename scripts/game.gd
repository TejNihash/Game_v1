extends Node2D

@onready var spawn_node: Node2D = $spawnNode
@onready var camera_2d: Camera2D = $Camera2D
@onready var player_health_bar: TextureProgressBar = $HUD/Player_health_bar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Gmanager.player_died.connect(show_game_over)
	print(get_tree().get_nodes_in_group("EnemiesGroup"))
	for enemy in get_tree().get_nodes_in_group("EnemiesGroup"):
		enemy.died.connect(_on_died)
		
	spawn_player()

func _on_died() -> void:
	print(get_tree().get_nodes_in_group("EnemiesGroup").size()-1," left")

	if get_tree().get_nodes_in_group("EnemiesGroup").size()<=1:
		print("ALL ENEMIES DEAD 🎉")
		show_game_over()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_player():
	
	print("spawning player")
	var path = Gmanager.selected_character_path
	
	# If no character was selected (testing the scene directly), use a default
	if path == "":
		path = Gmanager.char_1_scene
		
	# 1. Load the scene
	var character_scene = load(path)
	# 2. Create an instance of it
	var player = character_scene.instantiate()
	
	# 3. Position it at our spawn point
	player.global_position = spawn_node.global_position
	print(player.global_position)
	# 4. Add it to the world
	add_child(player)
	camera_2d.reparent(player)
	player_health_bar.connect_to_player(player) #connects player to healthbar
	print(player)


func show_game_over():
		%GameOver.visible = true
		await get_tree().create_timer(3.0).timeout
		get_tree().paused = true

	
