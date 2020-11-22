extends Node2D

func playareasounds(area:String):
	resetsounds();
	for child in get_children():
		if child.name == area:
			for c in child.get_children():
				print(c.get_class())
				if c.get_class() == "AudioStreamPlayer":
					c.play();

func resetsounds():
	for child in get_children():
		for c in child.get_children():
			if c.get_class() == "AudioStreamPlayer":
				c.stop();
