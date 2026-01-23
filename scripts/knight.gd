extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var is_attacking = false

func attack():
	is_attacking = true
	#attack_shape.disabled = false

	animated_sprite.play("attack1")
	# We turn the shape ON. It will now "listen" for collisions.

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#handle the attack
	if Input.is_action_just_pressed("attack"):
		attack()

		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	# this manages the direction
	if direction > 0:
		animated_sprite.flip_h  = false
		#weapon_pivot.scale.x = 1
	elif direction < 0: 
		animated_sprite.flip_h = true
		#weapon_pivot.scale.x = -1
		
		
	# this is for jump and run/idle

	if not is_attacking:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
				
		else:
			animated_sprite.play("jump")
	
	if direction:
		if is_attacking:
			velocity.x = direction *SPEED/4 
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	 # Replace with function body.
	if animated_sprite.animation == "attack1":
		is_attacking = false
