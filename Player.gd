extends RigidBody2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input(delta);


var bul = preload("res://Bullet.tscn")
var bul_cd = 0.2;
export var speed = 100;
func input(delta):
	if bul_cd >= 0:
		bul_cd -= delta
	if Input.is_action_pressed("m0"):
		if bul_cd <= 0:
			print("spawning bul")
			var bullet = bul.instance()
			bullet.position = position;
			get_parent().add_child(bullet)
			bullet.changedir((get_global_mouse_position() - position).normalized(), 500);
			bul_cd = 0
	
	var force = Vector2.ZERO;
	if Input.is_action_pressed("w"):
		force += Vector2.UP * delta * speed;
	if Input.is_action_pressed("a"):
		force += Vector2.LEFT * delta * speed;
	if Input.is_action_pressed("s"):
		force += Vector2.DOWN * delta * speed;
	if Input.is_action_pressed("d"):
		force += Vector2.RIGHT * delta * speed;
	apply_central_impulse(force);
