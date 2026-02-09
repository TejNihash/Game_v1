extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal died
signal health_changed(curr_health,max_health)


var is_attacking = false
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var visual_pivot: Node2D = $Visual_pivot

@onready var state_machine: Node = $StateMachine

var curr_attack:String

var damage_data = {
	"Attack1":{
	"damage":50,
	"knockback":130,
	"source":self,
	"position":global_position
},
"Attack2":{
	"damage":30,
	"knockback":100,
	"source":self,
	"position":global_position
	
}
}



var health = 100
var max_health  = 1000

const KNOCKBACK_RESIST := 1.0

func take_damage(data: Dictionary,opp_pos) -> void:
	
	print("player got attacked")
	health -= data.damage
	health_changed.emit(health,max_health)

	state_machine.change_state("Hurt")
	print("Player HP:", health)

	apply_knockback(data,opp_pos)
	if health <= 0:
		Gmanager.player_died.emit()
		state_machine.change_state("Death")


func apply_knockback(data: Dictionary,opp_pos) -> void:
	print("applying knockback")
	print(global_position)

	#print(data.position)
	var dir = (global_position - opp_pos).normalized()
	velocity += dir * data.knockback * KNOCKBACK_RESIST

func die():
	queue_free()


func _ready() -> void:
	state_machine.init(self)
	add_to_group("PlayersGroup")
	print("added to players group")

	
	
	

	
func enable_hitbox(name: String):
	$hitbox.get_node(name).monitoring = true

func disable_hitbox(name: String):
	$hitbox.get_node(name).monitoring = false

func disable_all_hitboxes():
	pass
	"""for h in $hitbox.get_children():
		h.monitoring = false"""


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()


func check_attack():
	var attack_state = false
	#check for J or K attack buttons.
	if Input.is_action_just_pressed("attack1"):
		state_machine.attack_action = "Attack1"
		attack_state = true
	elif Input.is_action_just_pressed("attack2"):
		state_machine.attack_action = "Attack2"
		attack_state = true
	return attack_state

func flip_body(dir):
	if dir >0:
		collision_shape_2d.position.x = -4
		visual_pivot.scale.x = 1
	else:
		collision_shape_2d.position.x = 4
		visual_pivot.scale.x = -1
		
		
		
