extends State

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter():
	if character.is_on_floor():
		character.velocity.y = character.JUMP_VELOCITY
	%AnimatedSprite2D.play("jump")

	
func update(delta):

	var direction = Input.get_axis("move_left", "move_right")
	#check for input. 
	#if normal movement, it will be handled normally so don't bother. 
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta
		character.velocity.x = direction * character.SPEED

	else:
		if direction == 0:
			state_machine.change_state("Idle")
		else:
			state_machine.change_state("Move")
		
	#if Input.is_action_just_pressed("attack1"):
	#	state_machine.change_state("Attack")
	if check_attack():
		state_machine.change_state("Attack")	
		
	
func exit():
	pass
