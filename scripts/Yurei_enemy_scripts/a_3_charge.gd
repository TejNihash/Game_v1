extends Area2D

@onready var speed = 300
@onready var max_distance = 400

var damage_data := {
	"damage":30,
	"knockback":200,
	"source":self,
	"position":global_position,
}

var direction = Vector2.RIGHT
var start_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	global_position += direction*speed*delta
	
	if global_position.distance_to(start_position) >= max_distance:

		queue_free()
	



func _on_area_entered(area: Area2D) -> void:
	
	
	if not area.has_method("receive_hit"):
		return

	
	var opp_pos = global_position # the opponent (presently the attacker's) position
	
	

	area.receive_hit(damage_data,opp_pos)
	queue_free()
