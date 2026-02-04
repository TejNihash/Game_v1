extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_attacking = false



@onready var attack_area: Area2D = $weapon_pivot/AttackArea
@onready var attack_shape: CollisionShape2D = $weapon_pivot/AttackArea/CollisionShape2D
@onready var weapon_pivot: Marker2D = $weapon_pivot

@onready var player_collision_box: CollisionShape2D = $CollisionShape2D


@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	add_to_group("PlayersGroup")


func attack():
	is_attacking = true
	attack_shape.disabled = false

	animated_sprite.play("attack1")
	# We turn the shape ON. It will now "listen" for collisions.

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "attack1":
		is_attacking = false
		# We turn the shape OFF so it doesn't hit things while idle.
		attack_shape.disabled = true
		
func _on_attack_area_area_entered(area: Area2D) -> void:
	if is_attacking and area.has_method("take_damage"):
		area.take_damage(25)
		animation_player.play("attack_proper")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#handle the attack
	if Input.is_action_just_pressed("attack1"):
		attack()

		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	# this manages the direction
	if direction > 0:
		animated_sprite.flip_h  = false
		player_collision_box.position.x = 5.0

		weapon_pivot.scale.x = 1
	elif direction < 0: 
		animated_sprite.flip_h = true
		player_collision_box.position.x = -5.0
		
		weapon_pivot.scale.x = -1
		
		
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
