extends TextureProgressBar

@onready var owner_body

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner_body = get_parent()
	while owner_body and not owner_body is CharacterBody2D:
		owner_body = owner_body.get_parent()

	max_value = owner_body.max_health
	value = owner_body.health

	owner_body.health_changed.connect(update_bar)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_bar(current:int,max:int) ->void:
	max_value = max
	value = current
