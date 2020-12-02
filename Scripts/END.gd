extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self, "_on_END_body_entered");
	end_disable();

func _on_END_body_entered(body):
	if body.name == "Player":
		if body.final_stage:
			end_enable();

func end_enable():
	$Bears.show();
	for child in get_children():
		if child.get_class() == "Area2D":
			for colliders in child.get_children():
				if colliders.get_class() == "CollisionShape2D":
					colliders.set_deferred("disabled", false);
	$sec_speak/CollisionShape2D.set_deferred("disabled", true);
	$ogi_speak/CollisionShape2D.set_deferred("disabled", true);
	$third_speak/CollisionShape2D.set_deferred("disabled", true);
	$ogi_speak2/CollisionShape2D.set_deferred("disabled", true);
	$fourth_speak/CollisionShape2D.set_deferred("disabled", true);

func end_disable():
	$Bears.hide();
	for child in get_children():
		if child.get_class() == "Area2D":
			for colliders in child.get_children():
				if colliders.get_class() == "CollisionShape2D":
					colliders.set_deferred("disabled", true);
