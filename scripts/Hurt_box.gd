extends Area2D

var owner_body

func _ready():
	
	owner_body = get_parent()
	
	while owner_body and not owner_body is CharacterBody2D:
		owner_body = owner_body.get_parent()

func receive_hit(damage_data: Dictionary,opp_pos) -> void:
	if owner_body.has_method("take_damage"):
		owner_body.take_damage(damage_data,opp_pos)
