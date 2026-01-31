extends Area2D

var health = 100
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal died

func take_damage(amount: int):
	health -= amount
	animation_player.play("hit_animation")
	print("Enemy hit! Health remaining: ", health)

func _ready():
	add_to_group("EnemiesGroup")


func die():
	queue_free() # Deletes the enemy
	

"""func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "hit":
		animated_sprite.play("default")# Replace with function body.
	
	if health <=0:
		died.emit()
		die()"""


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	 # Replace with function body.
	if anim_name == "hit_animation":
		animated_sprite.play("default")# Replace with function body.
	
	if health <=0:
		died.emit()
		die()
