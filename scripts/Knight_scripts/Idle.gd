extends State



func enter():
	
	#stop moving
	#character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)
	character.velocity.x = 0
	if character.has_node("AnimatedSprite2D"):
		character.get_node("AnimatedSprite2D").play("idle")
	

func update(delta):
	# we check for inputs.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		#we move right?
		state_machine.change_state("Move")
	elif Input.is_action_just_pressed("attack1"):
		state_machine.change_state("Attack")
		
	else:
		#just the general physics related stuff
		
		if not character.is_on_floor():
			character.velocity += character.get_gravity() * delta
		#move_toward(character.velocity.x, 0, character.SPEED)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("Jump")
	
	
func exit():
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
