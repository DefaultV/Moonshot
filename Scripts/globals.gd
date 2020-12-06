extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var player;
var mainshader;
func _ready():
	player = get_node("/root/World/Tilemaps_front/Trees/YSort/Player");
	mainshader = get_node("/root/World/UI/SHADERS");

func getPlayer():
	return player;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getMainshader():
	return mainshader;
