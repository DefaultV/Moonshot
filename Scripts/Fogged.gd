extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ply;
export var rate = 0.03;
# Called when the node enters the scene tree for the first time.
func _ready():
	ply = get_node("/root/World/Player")

var max_dist = 150;
var min_dist = 50;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rate >= 0:
		rate -= delta
		return
	var dist = ply.position.distance_to(position)
	if dist >= 300:
		modulate.a = 0;
		return

	dist = clamp(dist-max_dist, min_dist, max_dist);
	var norm = (dist - min_dist) / (max_dist - min_dist);
	norm = (1 - norm)
	#print(norm)
	modulate.a = norm
	rate = 0.03;

