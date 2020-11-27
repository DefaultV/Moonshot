extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ply;
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_enter");
	ply = get_node("/root/World/Player");

func _on_body_enter(body):
	if (body.name == "Player"):
		print("body")
		hide();
		ply.playtextblurp();

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
