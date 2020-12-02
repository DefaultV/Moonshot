extends TextureRect


func _ready():
	connect("visibility_changed", self, "creditsroll");
	
var trig = false;

func _process(delta):
	if trig:
		get_child(0).rect_position.y -= delta * 30;
		if get_child(0).rect_position.y <= -2600:
			print(get_child(0).rect_position.y);
			hide();
			trig = false;
			get_node("/root/World/region_audio/CREDITS_OST").stop();
			get_tree().quit();

func creditsroll():
	if not trig:
		trig = true;
