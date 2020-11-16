extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var point
export var trailLength = 10;
var cd = 0.1;
func _process(delta):
	if cd > 0.1:
		if (get_parent().get_parent().walking):
		#global_position = Vector2(0, 15);
			point = get_parent().get_parent().global_position;
			add_point(point);
			cd = 0.0;
	else:
		cd += delta;
	#if get_point_count() > trailLength:
	#	remove_point(0);
