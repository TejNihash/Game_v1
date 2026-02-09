extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var hurt_box: Area2D = $"../../Visual_pivot/hurt_box"

# Called when the node enters the scene tree for the first time.


func enter():
	print("entered death state for enemy")
	#animation_player.play("Death")

	animation_player.play("Death")

	
	character.velocity.x = 0
	
	
func update(delta):
	pass
	
	

func exit():
	pass






func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		character.die()
