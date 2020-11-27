extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "trigger_mono");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

export var monologue:PoolStringArray;
var triggered = false;
func trigger_mono(body):
	if triggered:
		return;
	if body.name == "Player":
		get_node("/root/World/UI/Inner_dialogue").newInnerDialogue(monologue, get_child(0).get_global_position());
		triggered = true;
