extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ply;
var pickup_ui;
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_enter");
	ply = get_node("/root/World/Player");
	pickup_ui = get_node("/root/World/UI/Itempickup");
var pickedup:bool = false;
func _on_body_enter(body):
	if (body.name == "Player") and not pickedup:
		print("body")
		hide();
		ply.playinventory();
		pickup_show();
		pickedup = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

export var ui_text_pickup:String;
func pickup_show():
	pickup_ui.get_child(0).bbcode_text = "[center][color=black]\""+ ui_text_pickup +"\"[/color][/center]";
	pickup_ui.texture = load(get_child(0).texture.resource_path);
	pickup_ui.show();
	yield(get_tree().create_timer(4.0),"timeout");
	pickup_ui.hide();
