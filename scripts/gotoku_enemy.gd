extends CharacterBody2D

signal health_changed(curr_health,max_health)

const SPEED = 50.0
const JUMP_VELOCITY = -400.0
@export var chase_distance = 105
@onready var state_machine: Node = $StateMachine
@export var attack_distance = 30 

var health = 1000
var max_health  = 1000

var player
var attack_list = ["Attack1", "Attack2", "Attack3"]
var curr_attack:String

var damage_data = {
	"Attack1":{
	"damage":30,
	"knockback":200,
	"source":self,
	"position":global_position
},
"Attack2":{
	"damage":30,
	"knockback":200,
	"source":self,
	"position":global_position
	
},
"Attack3":{
	"damage":50,
	"knockback":250,
	"source":self,
	"position":global_position
	
}
}

func _ready() -> void:
	print("enemy initiated")
	state_machine.init(self)

	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("PlayersGroup")
	print(player)
	print(self)
	add_to_group("EnemiesGroup")
	#add_to_group("EnemiesGroup")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	move_and_slide()
	
	
func enemy_to_player_dist():
	if player == null:
		return INF
	return abs(self.position.x-player.position.x)

func get_state():
	var dist = enemy_to_player_dist()
	
func get_attack():
	var random_index = randi_range(0, attack_list.size() - 1)
	
	var random_attack = attack_list[random_index]
	
	return random_attack


const KNOCKBACK_RESIST := 0.8

func take_damage(data: Dictionary,opp_pos) -> void:
	health -= data.damage
	health_changed.emit(health,max_health)

	print("Enemy HP:", health)
	state_machine.change_state("Hurt")
	apply_knockback(data,opp_pos)

	if health <= 0:
		die()

func apply_knockback(data: Dictionary,opp_pos) -> void:
	
	print("gotoku knockback")
	print(global_position)
	#print(data.position)
	print(opp_pos)
	var dir = (global_position - opp_pos).normalized()
	velocity += dir * data.knockback * KNOCKBACK_RESIST

func die():
	queue_free()
