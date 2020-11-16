extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var uishader;
# Called when the node enters the scene tree for the first time.
func _ready():
	uishader = get_node("/root/World/UI/SHADERS");
	uishader.material.set_shader_param("white_fade", 1.0);
	set_text("\"I've always wondered what's most important in life\"");
	show();


# Called every frame. 'delta' is the elapsed time since the previous frame.
var fade_amount = 1.0;
func _process(delta):
	yield(get_tree().create_timer(2.0), "timeout")
	if (fade_amount >= 0):
		fade_amount -= delta * 0.25;
		uishader.material.set_shader_param("white_fade", fade_amount);
		self_modulate.a = fade_amount;


func set_text(arg:String):
	bbcode_text = "[center][color=#000000]"+ arg +"[/color][/center]"
