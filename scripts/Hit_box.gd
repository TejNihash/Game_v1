extends Area2D


var owner_body

func _ready():
	area_entered.connect(_on_area_entered)
	
	owner_body = get_parent()
	
	while owner_body and not owner_body is CharacterBody2D:
		owner_body = owner_body.get_parent()

func _on_area_entered(area: Area2D) -> void:
	
	
	if not area.has_method("receive_hit"):
		return

	var damage_data = owner_body.damage_data[owner_body.curr_attack]
	
	var opp_pos = self.global_position #player position proxy
	
	print(damage_data)
	

	area.receive_hit(damage_data,opp_pos)
