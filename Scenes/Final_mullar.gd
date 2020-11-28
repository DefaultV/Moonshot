extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ply;
# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0.0;
	ply = get_node("/root/World/Player");


# Called every frame. 'delta' is the elapsed time since the previous frame.
var ply_vec:Vector2 = Vector2.ZERO;
var fade = 0.0;
var b_leave = false;
func _process(delta):
	if linear_velocity.length() >= 10:
		$scaling/Sprite.hide();
		$scaling/AnimatedSprite.show();
	else:
		$scaling/Sprite.show();
		$scaling/AnimatedSprite.hide();
	if b_leave:
		ply_vec = ((position - ply.position));
		apply_central_impulse(ply_vec.normalized()*delta*100);
		if fade > 0:
			fade -= delta * 0.15;
			modulate.a = fade;
		if fade <= 0:
			queue_free();
		return;
	if fade < 1:
		fade += delta * 0.5;
		modulate.a = fade;
	if ply.position.distance_to(position) > 60:
		ply_vec = ((ply.position - position));
	else:
		ply_vec = Vector2.ZERO;
	
	apply_central_impulse(ply_vec.normalized()*delta*100);

func leave():
	b_leave = true;
	print("leaving...")
