extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../Visual_pivot/AnimatedSprite2D"

# script of gotoku enemy
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


@export var patrol_speed := 40



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter():

	character.velocity.x = 0
	
	animated_sprite_2d.play("Idle")
	
	
func update(delta):
	#check for distance between this guy and the player
	if character.enemy_to_player_dist() <= character.attack_distance:
		state_machine.change_state("Attack")
	elif character.enemy_to_player_dist() <= character.chase_distance:
		state_machine.change_state("Run")



func exit():
	pass
