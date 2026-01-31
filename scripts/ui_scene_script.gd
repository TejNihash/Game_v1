extends Control

# Character paths (double-check these match your folder structure!)
const CHAR_1 = "res://scenes/player.tscn"
const CHAR_2 = "res://scenes/knight.tscn"

func _ready():
	# Connect buttons via code or use the 'Node' tab in editor
	$HBoxContainer/Char1_vbox/Button.pressed.connect(_on_char1_selected)
	$HBoxContainer/Char2_vbox/Button.pressed.connect(_on_char2_selected)



func _on_char1_selected():
	Gmanager.selected_character_path = CHAR_1
	start_game()

func _on_char2_selected():
	Gmanager.selected_character_path = CHAR_2
	start_game()

func start_game():
	# Simple scene transition
	#get_tree().change_scene_to_file("res://scenes/game.tscn")
	Transistion.fade_to_scene("res://scenes/game.tscn")
	
