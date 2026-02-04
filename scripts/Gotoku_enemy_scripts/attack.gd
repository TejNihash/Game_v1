extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var attack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter():
	attack = character.get_attack()
	character.curr_attack = attack #set the details.
	character.velocity.x = character.SPEED/60 # we don't want enemy to move much while attacking
	animation_player.play(attack)
	print(attack)
	
	
func update(delta):
	character.velocity.x = -character.SPEED/4
	character.velocity += character.get_gravity() * delta

	
	
func exit():
	pass
	
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	 # Replace with function body.
		if anim_name==attack:
			print("attack is done playing")
		if not character.is_on_floor():
			state_machine.change_state("Jump")
		else:
			state_machine.change_state("Idle")
	
