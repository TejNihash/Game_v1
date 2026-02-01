extends State

@onready var collision_shape_body: CollisionShape2D = $"../../CollisionShape2D"
@onready var attack_1_shape: CollisionShape2D = $"../../Visual_pivot/hitbox/attack1_shape"

@onready var visual_pivot: Node2D = $"../../Visual_pivot"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func enter():
	pass
	


	
func update(delta):
	var direction := Input.get_axis("move_left", "move_right")
	
	character.velocity += character.get_gravity() * delta


	# this manages the direction
	
	if direction > 0:
		"""character.animated_sprite.flip_h  = false
		collision_shape_2d.position.x = 38.0
		collision_shape_body.position.x = -4"""
		visual_pivot.scale.x = 1
		#weapon_pivot.scale.x = 1
	elif direction < 0: 
		"""character.animated_sprite.flip_h = true
		collision_shape_2d.position.x = -38.0
		collision_shape_body.position.x = 4"""
		visual_pivot.scale.x = -1

		
		#weapon_pivot.scale.x = -14
	if direction !=0:
		%AnimatedSprite2D.play("run")
		character.velocity.x = direction * character.SPEED
	
	if direction ==0:
		#direction is 0, which means idle brother. 
		character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)

		state_machine.change_state("Idle")
		

	#if Input.is_action_just_pressed("attack1"):
	if check_attack():
		state_machine.change_state("Attack")
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("Jump")
		
	
		
func exit():
	pass
