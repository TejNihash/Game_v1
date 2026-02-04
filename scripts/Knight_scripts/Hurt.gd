extends State

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter():
	animated_sprite_2d.play("hurt")
	
func update(delta):
	pass
	
func exit():
	pass
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == 'hurt':
		state_machine.change_state("Idle")
