extends CharacterBody2D

signal health_changed(curr_health,max_health)
signal died
const SPEED = 50.0
const WALK_SPEED = 120
const JUMP_VELOCITY = -400.0
@onready var state_machine: Node = $StateMachine

@export var chase_distance = 250
@onready var attack_distance = 100
@onready var long_range_attack_distance = attack_distance
@onready var short_attack_distance = 30
var random_index


@onready var visual_pivot: Node2D = $Visual_pivot

@export var charge3_scene:PackedScene
@onready var shoot_point_a_3: Node2D = $Visual_pivot/shoot_point_A3


var health = 1000
var max_health  = 1000

var player
var attack_list = ["Attack1", "Attack2", "Attack3"]#,"Attack4"]
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
	"knockback":220,
	"source":self,
	"position":global_position
	
},
"Attack4":{
	"damage":60,
	"knockback":250,
	"source":self,
	"position":global_position
	
}
}

func _ready() -> void:
	add_to_group("EnemiesGroup")

	print("enemy initiated")
	state_machine.init(self)

	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("PlayersGroup")
	print(player)
	print(self)
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
	pass
	
func get_attack():
	
	#different attacks for different ranges. 
	var dist_curr = enemy_to_player_dist()
	

	if dist_curr<=short_attack_distance:
		random_index = randi_range(0, 1)
	
	elif dist_curr <= long_range_attack_distance:
		random_index = randi_range(2,2)
		

	
	var random_attack = attack_list[random_index]
	
	return random_attack


const KNOCKBACK_RESIST := 0.8

func take_damage(data: Dictionary,opp_pos) -> void:

	
	health -= data.damage
	print("enemy hp left : ",health)
	#print("enemy is alive?  :",is_dead)
	if health>0 :
		health_changed.emit(health,max_health)

		state_machine.change_state("Hurt")
		apply_knockback(data,opp_pos)

	if health <= 0:
		print("enemy should die")
		
		
		state_machine.change_state("Death")
		print("changed to death state")

func apply_knockback(data: Dictionary,opp_pos) -> void:
	
	print("Yurei knockback")
	print(global_position)
	#print(data.position)
	print(opp_pos)
	var dir = (global_position - opp_pos).normalized()
	velocity += dir * data.knockback * KNOCKBACK_RESIST

func die():
	died.emit() #so that game can keep track of how many enemies alive
	queue_free()

func spawn_charge3():
	print("yurei attack has been charged")
	var charge3_scene = load("res://scenes/Yurei_scenes/A3_charge.tscn")
	var p = charge3_scene.instantiate()

	var dir = (player.global_position - global_position).normalized().x
	
	var facing_right = visual_pivot.scale.x >0
	facing_right = dir > 0 
	p.direction = Vector2(1 if facing_right else -1, 0)  # X-only movement
	print("brooo",p.direction)

	p.global_position = shoot_point_a_3.global_position
	get_tree().current_scene.add_child(p)
