#extends KinematicBody2D
extends RigidBody2D

func _ready():
	if debug_finalquest:
		for i in range(0, 5):
			appendQuest("test"+String(i))
	if debug_end:
		final_stage = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
export var debug_finalquest:bool = false;
export var debug_end:bool = false;
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	input(delta);

export var speed = 100;
var walking = false;
export var max_speed = 0.75;
var dir : Vector2 = Vector2.ZERO;
var movetopos = Vector2.ZERO;
var cinematic = false;
var canPressSpace = true;
var Inventory:PoolStringArray = [];
var qcompleted:PoolStringArray;
func getItemFromInventory(search_item:String) -> bool: 
	for item in Inventory:
		if item == search_item:
			return true;
	return false;

func appendItem(item:String):
	if not (getItemFromInventory(item)):
		Inventory.append(item);

func getQuest(search_quest:String) -> bool: 
	for quest in qcompleted:
		if quest == search_quest:
			return true;
	return false;

var fmul = preload("res://Prefabs/Final_mullar.tscn")
func appendQuest(q:String):
	if not (getQuest(q)):
		qcompleted.append(q);
		print(len(qcompleted))
		if len(qcompleted) >= 6:
			final_stage = true;
			yield(get_tree().create_timer(5.0), "timeout")
			fmul = fmul.instance();
			fmul.position = position + Vector2(100, 100);
			get_parent().add_child(fmul);

var final_stage = false;

func switch_animation(arg:String):
	if arg == "i" and not $Idle.visible:
		$Front_run_anim.hide();
		$Idle.show();
		$Run_anim.hide();
	if arg == "v" and not $Run_anim.visible:
		$Front_run_anim.hide();
		$Idle.hide();
		$Run_anim.show();
	if arg == "h" and not $Front_run_anim.visible:
		$Front_run_anim.show();
		$Idle.hide();
		$Run_anim.hide();
var front_run:bool = false;
var side_run = 0.6;
func input(delta):
	walking = (linear_velocity.length() > 10);
	$walk.stream_paused = !walking;
	if walking and not front_run:
		switch_animation("v");
	elif front_run:
		switch_animation("h");
	else:
		switch_animation("i");
	if cinematic:
		return;
	var force = Vector2.ZERO;
	if Input.is_action_just_pressed("map"):
		var map = get_node("/root/World/UI/Map");
		if map.is_visible():
			map.hide();
			$map_close.play();
		else:
			map.show();
			$map_open.play();
	front_run = false;
	if Input.is_action_pressed("w"):
		force += Vector2.UP * delta * speed;
	if Input.is_action_pressed("a"):
		force += Vector2.LEFT * delta * speed;
		$Run_anim.flip_h = true;
		
	if Input.is_action_pressed("s"):
		force += Vector2.DOWN * delta * speed;
		front_run = true;
	if Input.is_action_pressed("d"):
		force += Vector2.RIGHT * delta * speed;
		$Run_anim.flip_h = false;

	if Input.is_action_pressed("a") and Input.is_action_pressed("w"):
		force = Vector2.LEFT * delta * speed;
		force += Vector2.UP*side_run * delta * speed;
	if Input.is_action_pressed("d") and Input.is_action_pressed("w"):
		force = Vector2.RIGHT* delta * speed;
		force += Vector2.UP*side_run* delta * speed;
	if Input.is_action_pressed("a") and Input.is_action_pressed("s"):
		force = Vector2.LEFT* delta * speed;
		force += Vector2.DOWN*side_run * delta * speed;
		front_run = false;
	if Input.is_action_pressed("d") and Input.is_action_pressed("s"):
		force = Vector2.RIGHT* delta * speed;
		force += Vector2.DOWN*side_run * delta * speed;
		front_run = false;
	apply_central_impulse(force.normalized() * max_speed * delta);

	## MOUSE CONTROLS ##
	#if Input.is_action_pressed("m0"):
	#	movetopos = get_global_mouse_position();
	#else:
	#	movetopos = position;
	#if (movetopos.distance_to(position) > 5 and movetopos != Vector2.ZERO):
	#	dir = movetopos - position;
	#	apply_central_impulse(dir.normalized() * max_speed * delta)
	####################

func playchimes():
	if not $Chimes.playing:
		$Chimes.play();

func stopwalk():
	#dir = position;
	walking = false;
	movetopos = position;

func playshake():
	$shake.play();

func playtent(state:bool):
	if state:
		$tent_open.play();
		clearfootsteps();
	else:
		$tent_close.play();

func playtextblurp():
	$text_continue.play();

func playbugnet():
	$bug_net.play();

func playmap(state:bool):
	if state:
		$map_open.play();
	else:
		$map_close.play();

func playinventory():
	$inventory.play();

func setwalkdb(arg):
	$walk.volume_db = arg;

func setpos(pos:Vector2):
	reset_state = true;
	newpos = pos;

var reset_state = false;
var newpos = Vector2.ZERO;
func _integrate_forces(state):
	if reset_state:
		state.transform = Transform2D(0.0, newpos)
		clearfootsteps();
		reset_state = false

func clearfootsteps():
	$globalparentline/Line2D.remove_footsteps();
