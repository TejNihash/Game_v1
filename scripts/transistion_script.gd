extends CanvasLayer

@onready var rect: ColorRect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func fade_to_scene(scene_path:String,duration := 1):
	rect.visible = true 
	rect.modulate.a = 0.0

	
	
	var packed_scene = load(scene_path)

	var tween = get_tree().create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, duration) # fade OUT
	tween.tween_callback(func():
		get_tree().change_scene_to_packed(packed_scene)
	)
	tween.tween_property(rect, "modulate:a", 0.0, duration) # fade IN
