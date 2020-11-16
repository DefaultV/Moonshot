#extends KinematicBody2D
extends RigidBody2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	input(delta);

export var speed = 100;
var walking = false;
export var max_speed = 0.75;
var dir : Vector2 = Vector2.ZERO;
var movetopos = Vector2.ZERO;
var cinematic = false;
func input(delta):
	walking = (linear_velocity.length() > 3);
	$walk.stream_paused = !walking;
	if cinematic:
		return;
	var force = Vector2.ZERO;
	if Input.is_action_just_pressed("map"):
		var map = get_node("/root/World/UI/Map");
		if map.is_visible():
			map.hide();
		else:
			map.show();
	if Input.is_action_pressed("m0"):
		movetopos = get_global_mouse_position();
	else:
		movetopos = position;
	#if Input.is_action_pressed("w"):
	#	force += Vector2.UP * delta * speed;
	#if Input.is_action_pressed("a"):
	#	force += Vector2.LEFT * delta * speed;
	#if Input.is_action_pressed("s"):
	#	force += Vector2.DOWN * delta * speed;
	#if Input.is_action_pressed("d"):
	#	force += Vector2.RIGHT * delta * speed;
	
	#apply_central_impulse(force.normalized() * max_speed * delta);
	if (movetopos.distance_to(position) > 5 and movetopos != Vector2.ZERO):
		dir = movetopos - position;
		apply_central_impulse(dir.normalized() * max_speed * delta)
	#move_and_slide(force);

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
	else:
		$tent_close.play();

func playtextblurp():
	$text_continue.play();

func setwalkdb(arg):
	$walk.volume_db = arg;
