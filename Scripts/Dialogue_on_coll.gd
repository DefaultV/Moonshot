extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cam;
var dialogue;
var dialogue_rect;
var ply;
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Mullar_tut_body_entered");
	connect("body_exited", self, "_on_Mullar_tut_body_exited");
	cam = get_node("/root/World/Camera2D");
	ply = get_node("/root/World/Player");
	dialogue = get_node("/root/World/UI/Dialogue");
	dialogue_rect = get_node("/root/World/UI/Dialogue_rect");
	dialogue_state(false)

func dialogue_state(vis):
	if vis:
		dialogue.show()
		dialogue_rect.show()
	else:
		dialogue.hide()
		dialogue_rect.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ply.cinematic:
		if Input.is_action_just_released("m1") and this:
			ply.playtextblurp()
			if not next_dialogue_part() or visited:
				dialogue_state(false)
				ply.cinematic = false;
				cam.hook_free();

export var hook_zoom_amount: Vector2;
export var speech: String;
export var speech_array:PoolStringArray = []
var adds = ["\n[center][color=white][shake rate=3 level=5]", "[/shake][/color][/center]"]
func _on_Mullar_tut_body_entered(body):
	if body.name != "Player":
		return;
	print(body.name + " entered")
	cam.hook_zoom(global_position, hook_zoom_amount);
	if visited and replay_dialogue:
		visited = false;
		speech_idx = 1;
	if visited:
		dialogue.bbcode_text = adds[0] + speech + adds[1];
	else:
		dialogue.bbcode_text = adds[0] + speech_array[0] + adds[1];
	this = true;
	if chimeorshake:
		ply.playchimes();
	else:
		ply.playshake();
	ply.stopwalk();
	ply.cinematic = true;
	dialogue_state(true)

export var replay_dialogue = false;
export var chimeorshake = true;
var this = false;
var visited = false;
var speech_idx = 1;
func next_dialogue_part():
	dialogue.resetscroll()
	if speech_array.size() != speech_idx:
		dialogue.bbcode_text = adds[0] + speech_array[speech_idx] + adds[1]
		speech_idx+=1;
		return true
	return false

func _on_Mullar_tut_body_exited(body):
	if body.name != "Player":
		return;
	this = false;
	print(body.name + " exited")
	cam.hook_free();
	dialogue_state(false)
	visited = true;
	ply.cinematic = false;
