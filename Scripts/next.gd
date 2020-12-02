extends Node2D


func _ready():
	connect("visibility_changed", self, "final");
var trig = false;

export var chapter_idx = 1;

func final():
	if trig:
		return;
	trig = true;
	if chapter_idx == 1:
		get_node("/root/World/Interactives/END/Items").endchapter2();
	if chapter_idx == 2:
		get_node("/root/World/Interactives/END/Items").endchapter3();
	if chapter_idx == 3:
		get_node("/root/World/Interactives/END/Items").endchapter4();
	if chapter_idx == 4:
		yield(get_tree().create_timer(13.0), "timeout");
		get_node("/root/World/UI/WHITE").show();
		get_node("/root/World/region_audio/CHANT_OST").stop();
		get_node("/root/World/region_audio/CREDITS_OST").play();
