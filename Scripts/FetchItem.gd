extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var pickup_ui;
func _ready():
	pickup_ui = get_node("/root/World/UI/Itempickup");
	connect("body_entered", self, "_on_body_enter");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

export (String, "fishingbait", "leaf", "water", "book", "plan", "rug") var Item_to_give;

var found = false;
func _on_body_enter(body):
	if body.name == "Player" and not found:
		body.appendItem(Item_to_give);
		print("Gave player item: " + Item_to_give)
		hide();
		found = true;
		pickup_show();
		get_node("/root/World/Player").playtextblurp();

export var ui_text_pickup:String;
func pickup_show():
	pickup_ui.get_child(0).bbcode_text = "[center][color=black]\""+ ui_text_pickup +"\"[/color][/center]";
	pickup_ui.texture = load(get_child(0).texture.resource_path);
	pickup_ui.show();
	yield(get_tree().create_timer(4.0),"timeout");
	pickup_ui.hide();
