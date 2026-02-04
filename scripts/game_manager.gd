extends Node

signal player_died
# This holds the scene path of the chosen character
var selected_character_path: String = ""

# Preload your scenes here for easy access
var char_1_scene = "res://scenes/player.tscn"
var char_2_scene = "res://scenes/knight.tscn"
