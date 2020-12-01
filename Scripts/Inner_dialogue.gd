extends RichTextLabel


var uishader;
# Called when the node enters the scene tree for the first time.
var next_dia;
var inner_pic:TextureRect;
var ply;
func _ready():
	ply = get_node("/root/World/Player");
	uishader = get_node("/root/World/UI/SHADERS");
	inner_pic = get_parent().get_node("Inner_pic");
	if skip_intro:
		return;
	uishader.material.set_shader_param("white_fade", 1.0);
	next_dia = NextInnerDialogue()
	ply.cinematic = true;
	inner_pic.self_modulate.a = 0.0;
	inner_pic.show();
	show();


export var skip_intro:bool = false;

var fade_amount = 1.0;
var fade_amount_pic = 1.0;
var fade_cd:float;
var dia_amount = 0;
var dia_count = 1;
var picfaded = false;
var custom:bool = false;
## Don't ask, I'm experimenting with yield(s)
func _process(delta):
	if skip_intro or next_dia == null:
		return
	yield(get_tree().create_timer(1.0), "timeout");
	if dia_amount <= dia_count:
		self_modulate.a = min(self_modulate.a, 1);
		if (fade_cd > 0):
			if not picfaded:
				inner_pic.self_modulate.a += delta * 0.5; # Picture fade
				if (custom):
					uishader.material.set_shader_param("white_fade", inner_pic.self_modulate.a); # Dont ever do this in real code
				if inner_pic.self_modulate.a >= 1:
					picfaded = true;
			self_modulate.a += delta * 0.5;
			fade_cd -= delta
			#print(self_modulate.a)
		else:
			self_modulate.a -= delta * 0.5;
			if self_modulate.a <= 0:
				if (dia_count != 1) or len(str_array_external) == 0:
					print("next dia");
					next_dia.resume()
					#fade_cd = 4.0;
				dia_amount += 1;
	else:
		if (fade_amount >= 0):
			if custom:
				if monologue_pos != Vector2.ZERO:
					ply.setpos(monologue_pos);
				custom = false;
				monologue_pos = Vector2.ZERO;
			fade_amount -= delta * 0.25;
			fade_amount_pic -= delta;
			uishader.material.set_shader_param("white_fade", fade_amount);
			inner_pic.self_modulate.a = fade_amount_pic;
			ply.cinematic = false;
			ply.canPressSpace = true;
			#print("end cinematic");
			#self_modulate.a = fade_amount;
			#hide();

func NextInnerDialogue():
	fadeNewText("All the people I've met have been sweet, that's why I call them my friends.", 6.0)
	yield()
	fadeNewText("Here, everyone is happy, everyone is nice. Love is what we nurture.", 4.0)
	yield()

func fadeNewText(arg:String, cd:float):
	self_modulate.a = 0;
	fade_cd = cd;
	print("fade_cd set: " + String(fade_cd))
	set_text("\""+arg+"\"");
	print("setting text" + arg);

func set_text(arg:String):
	bbcode_text = "[center][color=#000000]"+ arg +"[/color][/center]"

var monologue_pos:Vector2;
var str_array_external:PoolStringArray;
func newInnerDialogue(stringarray:PoolStringArray, pos:Vector2):
	get_node("/root/World/region_audio").resetsounds();
	ply.playchimes();
	ply.cinematic = true;
	monologue_pos = pos;
	show();
	custom = true;
	skip_intro = false;
	fade_amount = 1.0;
	fade_amount_pic = 1.0;
	fade_cd = 1.0;
	dia_amount = 0;
	dia_count = len(stringarray);
	print("monologue_len: " + String(len(stringarray)))
	picfaded = false;
	str_array_external = stringarray;
	#uishader.material.set_shader_param("white_fade", 1.0);
	inner_pic.self_modulate.a = 0.0;
	inner_pic.show();
	next_dia = pause();

func pause():
	print(str_array_external[0])
	fadeNewText(str_array_external[0], 4.0);
	yield();
	fadeNewText(str_array_external[1], 4.0);
	print(str_array_external[1])
	yield();
	fadeNewText(str_array_external[2], 4.0);
	print(str_array_external[2])
	yield();
	fadeNewText(str_array_external[3], 4.0);
	yield();
	fadeNewText(str_array_external[4], 4.0);
	yield();
