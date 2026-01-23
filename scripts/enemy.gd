extends Area2D

var health = 100
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

signal died

func take_damage(amount: int):
	health -= amount
	animated_sprite.play("hit")
	print("Enemy hit! Health remaining: ", health)

func _ready():
	add_to_group("EnemiesGroup")


func die():
	queue_free() # Deletes the enemy
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "hit":
		animated_sprite.play("default")# Replace with function body.
	
	if health <=0:
		died.emit()
		die()
