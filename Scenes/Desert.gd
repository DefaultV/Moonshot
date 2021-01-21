extends Node2D

var uishader;
var fade = 0.0;
var bfade = false;

func _ready():
	uishader = get_node("/root/World/UI/SHADERS");
	connect("body_entered", self, "_on_Mullar_body_entered");
	connect("body_exited", self, "_on_Mullar_body_exited");

func _on_Mullar_body_entered(body):
	if body.name == "Player":
		uishader.material.set_shader_param("apply_desert", true);
		bfade = true;

func _on_Mullar_body_exited(body):
	if body.name == "Player":
		bfade = false;

func _process(delta):
	if fade < 1 and bfade:
		fade += delta;
		uishader.material.set_shader_param("desert_amount", fade*0.5);
	elif fade > 0 and not bfade:
		fade -= delta;
		uishader.material.set_shader_param("desert_amount", fade*0.5);
