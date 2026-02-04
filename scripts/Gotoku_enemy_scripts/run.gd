extends State


@onready var visual_pivot: Node2D = $"../../Visual_pivot"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../Visual_pivot/AnimatedSprite2D"

var enemy 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter():
	enemy = character
	enemy.velocity.x = enemy.SPEED/10
	animated_sprite_2d.play("Walk")

	
func update(delta):
	var direction = sign(enemy.player.position.x - enemy.position.x)
	#turn that guy left or right based on the direction of player
	if direction>0:
		visual_pivot.scale.x = 1
	else:
		visual_pivot.scale.x = -1
		
	#make him move that way too.
	if enemy.enemy_to_player_dist()< enemy.chase_distance:
		enemy.velocity.x = direction*enemy.SPEED
	else:
		state_machine.change_state("Idle")
	
	
	if enemy.enemy_to_player_dist()<enemy.attack_distance:
		state_machine.change_state("Attack")


func exit():
	pass
	
