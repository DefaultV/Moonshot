extends RichTextLabel


var uishader;
# Called when the node enters the scene tree for the first time.
var next_dia;
func _ready():
	if skip_intro:
		return;
	uishader = get_node("/root/World/UI/SHADERS");
	uishader.material.set_shader_param("white_fade", 1.0);
	next_dia = NextInnerDialogue()
	show();


export var skip_intro:bool = false;

var fade_amount = 1.0;
var fade_cd:float;
var dia_amount = 0;
## Don't ask, I'm experimenting with yield(s)
func _process(delta):
	if skip_intro:
		return
	if dia_amount <= 1:
		self_modulate.a = min(self_modulate.a, 1);
		if (fade_cd > 0):
			self_modulate.a += delta * 0.5;
			fade_cd -= delta
		else:
			self_modulate.a -= delta * 0.5;
			if self_modulate.a <= 0:
				next_dia.resume()
				dia_amount += 1;
	else:
		if (fade_amount >= 0):
			fade_amount -= delta * 0.25;
			uishader.material.set_shader_param("white_fade", fade_amount);
			#self_modulate.a = fade_amount;

func NextInnerDialogue():
	fadeNewText("All the people I've met have been sweet, that's why I call them my friends.", 6.0)
	yield()
	fadeNewText("Here, everyone is happy, everyone is nice. Love is what we nurture.", 4.0)
	yield()

func fadeNewText(arg:String, cd:float):
	self_modulate.a = 0;
	fade_cd = cd;
	set_text("\""+arg+"\"");

func set_text(arg:String):
	bbcode_text = "[center][color=#000000]"+ arg +"[/color][/center]"
