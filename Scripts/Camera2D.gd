extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var ply;
func _ready():
	ply = get_node("/root/World/Player");


# Called every frame. 'delta' is the elapsed time since the previous frame.
export var lerpspeed = 1
export var zoomspeed = 0.1;
export var zoom_clamp:Vector2;
var zoomed = Vector2.ONE * 0.5;

func _process(delta):
	if (hooked):
		position = lerp(position, hooked_zoom, delta * lerpspeed);
		zoom = lerp(zoom, (zoomed), delta * lerpspeed * 2);
		ply.setwalkdb(int(-zoom.x * 10) - 25);
		return;
	position = lerp(position, ply.position, delta * lerpspeed);
	if Input.is_action_just_released("mwdown"):
		zoomed += Vector2.ONE * zoomspeed;
	if Input.is_action_just_released("mwup"):
		zoomed -= Vector2.ONE * zoomspeed;
	zoomed.x = clamp(zoomed.x, zoom_clamp.x, zoom_clamp.y);
	zoomed.y = clamp(zoomed.y, zoom_clamp.x, zoom_clamp.y);
	zoom = lerp(zoom, (zoomed), delta * lerpspeed * 2);
	ply.setwalkdb(int(-zoom.x * 10) - 25);
#	pass

var hooked = false;
var hooked_zoom = Vector2.ONE;
var old_zoom = Vector2.ZERO;
func hook_zoom(pos, zoomamount):
	hooked = true;
	hooked_zoom = pos;
	old_zoom = zoomed;
	zoomed = zoomamount;

func hook_free():
	hooked = false;
	zoomed = old_zoom;
	hooked_zoom = Vector2.ONE;
