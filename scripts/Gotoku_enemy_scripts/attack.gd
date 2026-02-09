extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var visual_pivot: Node2D = $"../../Visual_pivot"

var attack
var dir #direction of facing

var enemy
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter():
	enemy = character
	attack = character.get_attack()
	character.curr_attack = attack #set the details.
	
	dir = (character.player.global_position - character.global_position).normalized().x

	#dd dir = visual_pivot.scale.x

	character.velocity.x = dir*character.SPEED/60 # we don't want enemy to move much while attacking
	animation_player.play(attack)
	print(attack)
	
	
func update(delta):
	
	
	var direction = sign(enemy.player.position.x - enemy.position.x)
	#turn that guy left or right based on the direction of player
	if direction>0:
		visual_pivot.scale.x = 1
	else:
		visual_pivot.scale.x = -1
		
	character.velocity.x = dir*character.SPEED/4
	character.velocity += character.get_gravity() * delta

	
	
func exit():
	pass
	
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	 # Replace with function body.
	print("yurei attack is over")
	if anim_name==attack:
		pass
			#print("attack is done playing")
		#if not character.is_on_floor():
			#state_machine.change_state("Jump") #this char doesn't have jump so check it out later.
		#else:
	state_machine.change_state("Idle")
	
