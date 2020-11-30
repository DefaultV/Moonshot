extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var bridge_sprite = preload("res://spacey's space/bridge_fixed.png");
func _on_Bridge_area_body_entered(body):
	if body.name == "Player":
		if body.getItemFromInventory("planks"):
			repairbridge();

func repairbridge():
	get_parent().texture = bridge_sprite;
	get_parent().get_child(0).get_child(0).set_deferred("disabled", true)
	print(get_parent().get_child(0).get_child(0))
	# PLAY REPAIR SOUND
