extends Node2D


const SPEED_INSIDE = 50;
const SPEED_OUTSIDE = 75;

var ply;
var cam;

func _ready():
	ply = get_node("/root/World/Player");
	cam = get_node("/root/World/Camera2D");

#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	enterState(true, body);
	print("Entered tent")


func _on_Area2D_body_exited(body):
	enterState(false, body);

func enterState(state:bool, body):
	if body.name == "Player":
		if not (state):
			hide();
			ply.z_index = 2;
			ply.max_speed = SPEED_OUTSIDE;
			cam.hook_free();
		else:
			print("Show inside")
			show();
			ply.z_index = 5;
			ply.playtent(true);
			ply.max_speed = SPEED_INSIDE;
			cam.hook_zoom(body.position + Vector2(25, -10), Vector2(0.1, 0.1));
		ply.playtent(state);
