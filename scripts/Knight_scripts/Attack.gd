extends State


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var collision_shape_2d: CollisionShape2D = $"../../hitbox/CollisionShape2D"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func enter():
	#animated_sprite_2d.play("attack1")
	animation_player.play("Attack1")
	
	
func update(delta):
	var direction := Input.get_axis("move_left", "move_right")
	character.velocity.x = direction * character.SPEED/4
	character.velocity += character.get_gravity() * delta

	



	
func exit():
	character.disable_all_hitboxes()
	
"""func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == 'attack1':
		print("attack is done playing")
		state_machine.change_state("Move")
	"""


func _on_hitbox_area_entered(area: Area2D) -> void:
	print("hit")
	if area.has_method("take_damage"):
		area.take_damage(25)
			


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	 # Replace with function body.
	if anim_name=='Attack1':
		print("attack is done playing")
		if not character.is_on_floor():
			state_machine.change_state("Jump")
		else:
			state_machine.change_state("Move")
	
