extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func changedir(vec, speed):
	linear_velocity = Vector2.ZERO;
	apply_central_impulse(vec * speed);
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
