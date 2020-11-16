extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_param("wind_speed", rand_range(0.2, 0.5));
	material.set_shader_param("wind_stength", rand_range(0.01, 0.05));


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
