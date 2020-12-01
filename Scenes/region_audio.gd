extends Node2D


var new_ost;
var old_ost;
var oldarea:String = "";
func playareasounds(area:String):
	if (oldarea == area):
		print("Duplicate area sound, ignoring...")
		return;
	oldarea = area;
	old_ost = new_ost;
	if old_ost != null:
		print("old: " + old_ost.get_parent().name)
	switching = true;
	resetList();
	#resetsounds();
	for child in get_children():
		if child.name == area:
			for c in child.get_children():
				print(c.get_class())
				if c.get_class() == "AudioStreamPlayer":
					c.play();
					new_ost = c;
					print("new: " + area);
					if (area == "Kingdom"):
						fade_to = -22.5; # Hardcode kingdom DB
					else:
						fade_to = -30;

func resetsounds():
	resetList();
	force = true;
	switching = true;
	yield(get_tree().create_timer(10), "timeout");
	resetList();
	force_in = true;
	switching = true;

var force = false;
var force_in = false;
var switching:bool = false;
var fade:float = -60;
var fade_end:float = -30;
var fade_to:float = -30;
func _process(delta):
	if switching:
		if (force):
			if fade < -30:
				fade += delta * 5;
				fade_end -= delta * 7;
				new_ost.volume_db = fade_end;
			else:
				resetList();
				switching = false;
				force = false;
				#new_ost.stop();
			return;
		if (force_in):
			if fade < -30:
				#new_ost.play();
				fade += delta * 5;
				fade_end -= delta * 7;
				new_ost.volume_db = fade;
			else:
				resetList();
				switching = false;
				force_in = false;
			return;
		
		if fade < fade_to:
			fade += delta * 5;
			fade_end -= delta * 7;
			new_ost.volume_db = fade;
			if (old_ost != null):
				old_ost.volume_db = fade_end;
		else:
			print("reset/ready");
			if (old_ost != null):
				old_ost.stop();
			resetList();
			switching = false;

func resetList():
	fade = -60;
	fade_end = -30;
