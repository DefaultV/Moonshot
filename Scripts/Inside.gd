extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var ply;
var cam;
func _ready():
	ply = get_node("/root/World/Player");
	cam = get_node("/root/World/Camera2D");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if (body.name == "Player"):
		show();
		ply.z_index = 5;
		ply.playtent(true);
		ply.max_speed = 50;
		cam.hook_zoom(body.position + Vector2(25, -10), Vector2(0.1, 0.1));


func _on_Area2D_body_exited(body):
	if (body.name == "Player"):
		ply.z_index = 2;
		hide();
		ply.playtent(false);
		cam.hook_free();
		ply.max_speed = 75;
