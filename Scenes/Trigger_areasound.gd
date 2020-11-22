extends Area2D

export (String, "Start", "Forest", "Garden", "Kingdom", "Desert", "Village") var area;

func _ready():
	connect("body_entered", self, "_on_body_enter_trigger_sound");

func _on_body_enter_trigger_sound(body):
	if (body.name =="Player"):
		print("Playing sounds for area: " + area);
		get_parent().playareasounds(area);
