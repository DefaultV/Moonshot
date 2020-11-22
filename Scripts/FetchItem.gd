extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_enter");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

export (String, "fishingbait", "leaf", "bread", "book") var Item_to_give;

var found = false;
func _on_body_enter(body):
	if body.name == "Player" and not found:
		body.appendItem(Item_to_give);
		print("Gave player item: " + Item_to_give)
		hide();
		found = true;
