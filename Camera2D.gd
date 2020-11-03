extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var ply;
func _ready():
	ply = get_node("/root/World/Player");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = lerp(position, ply.position, delta);
#	pass
