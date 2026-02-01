extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var is_attacking = false

@onready var state_machine: Node = $StateMachine

func _ready() -> void:
	state_machine.init(self)
	
	
	

func attack1():
	is_attacking = true
	#attack_shape.disabled = false
	%AnimatedSprite2D.play("attack1")
	# We turn the shape ON. It will now "listen" for collisions.
func attack2():
	is_attacking = true
	#attack_shape.disabled = false
	%AnimatedSprite2D.play("attack2")
	# We turn the shape ON. It will now "listen" for collisions.
func combo_attack():
	is_attacking = true
	#attack_shape.disabled = false
	%AnimatedSprite2D.play("combo_attack")
	# We turn the shape ON. It will now "listen" for collisions.
	
func enable_hitbox(name: String):
	$hitbox.get_node(name).monitoring = true

func disable_hitbox(name: String):
	$hitbox.get_node(name).monitoring = false

func disable_all_hitboxes():
	pass
	"""for h in $hitbox.get_children():
		h.monitoring = false"""


func _physics_process(delta: float) -> void:
	
	move_and_slide()

	# Add the gravity.
	
"""	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#handle the attack
	if Input.is_action_just_pressed("attack1"):
		attack1()
	elif Input.is_action_just_pressed("attack2"):
		attack2()
	elif Input.is_action_just_pressed("combo_attack"):
		combo_attack()

		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	# this manages the direction
	if direction > 0:
		%AnimatedSprite2D.flip_h  = false
		#weapon_pivot.scale.x = 1
	elif direction < 0: 
		%AnimatedSprite2D.flip_h = true
		#weapon_pivot.scale.x = -1
		
		
	# this is for jump and run/idle

	if not is_attacking:
		if is_on_floor():
			if direction == 0:
				%AnimatedSprite2D.play("idle")
			else:
				%AnimatedSprite2D.play("run")
				
		else:
			%AnimatedSprite2D.play("jump")
	
	if direction:
		if is_attacking:
			velocity.x = direction *SPEED/4 
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
"""
