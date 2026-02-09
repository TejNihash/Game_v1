extends TextureProgressBar

@onready var owner_body


# Called when the node enters the scene tree for the first time.
func connect_to_player(player):
	player.health_changed.connect(update_bar)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_bar(current:int,max:int) ->void:
	max_value = max
	value = current
