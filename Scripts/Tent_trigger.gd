extends Area2D

func _ready():
	connect("body_entered", self, "callInside");
	connect("body_exited", self, "callOutside");


func callInside(body):
	if body.name == "Player":
		get_node("/root/World/Inside_overlay").enterState(true, body);

func callOutside(body):
	if body.name == "Player":
		get_node("/root/World/Inside_overlay").enterState(false, body);
