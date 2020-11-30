extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
export var spawner:bool = false;
export var from:Vector2;
export var to:Vector2;
export var spawn_timer:float = 2;
export var dir = Vector2.ZERO;
export var lifetime:float = 30;

var tumbleweed_prefab = load("res://Prefabs/Tumbleweed.tscn");

func _process(delta):
	if not spawner:
		#print(lifetime)
		if lifetime > 0:
			lifetime -= delta;
			position += dir * delta * 50;
		else:
			queue_free();
	else:
		#print(spawn_timer)
		spawn_timer -= delta;
		if spawn_timer < 0:
			spawn_timer = 2;
			spawn_tumbleweed();

func spawn_tumbleweed():
	var tw = tumbleweed_prefab.instance();
	tw.position = Vector2(rand_range(from.x, to.x), rand_range(from.y, to.y));
	tw.dir = Vector2(rand_range(0.6, 1), rand_range(0, 0.5));
	add_child(tw);
