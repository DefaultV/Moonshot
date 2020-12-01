extends Node2D

func _ready():
	connect("visibility_changed", self, "endchapter");

var ending = false;
var no_cape = load("res://spacey's space/bears/prince bear no cape.png")
func endchapter():
	if ending:
		return;
	ending = true;
	get_node("/root/World/Player").cinematic = true;
	get_node("/root/World/Camera2D").hook_zoom(global_position, Vector2(0.7, 0.7));
	# remove items
	yield(get_tree().create_timer(5.0), "timeout");
	hide();

	#remove royal items
	yield(get_tree().create_timer(2.0), "timeout");
	get_node("/root/World/Interactives/King_mullar/Crown").hide();
	get_node("/root/World/Interactives/King_mullar/Scepter").hide();
	get_node("/root/World/Interactives/Queen_mullar/Crown").hide();
	get_node("/root/World/Interactives/RoyalSon_mullar/Sprite").texture = no_cape;
	get_node("/root/World/region_audio/Kingdom/kingdom_ost").stop();
	
	#spawn ogi
	yield(get_tree().create_timer(1.0), "timeout");
	get_node("/root/World/region_audio/OGI_OST").play();
	yield(get_tree().create_timer(3.0), "timeout");
	get_node("/root/World/Interactives/Ogi").show();
	yield(get_tree().create_timer(2.0), "timeout");
	get_node("/root/World/Interactives/END/ogi_speak/CollisionShape2D").set_deferred("disabled", false);
	

func endchapter2():
	get_node("/root/World/Player").cinematic = true;
	get_node("/root/World/Camera2D").hook_zoom(global_position, Vector2(0.7, 0.7));
	get_node("/root/World/Interactives/Ogi/SHADOW/AnimationPlayer").play("shadow_ogi");
	yield(get_tree().create_timer(5.0), "timeout");
	get_node("/root/World/Interactives/END/third_speak/CollisionShape2D").set_deferred("disabled", false);

func endchapter3():
	get_node("/root/World/Player").cinematic = true;
	get_node("/root/World/Camera2D").hook_zoom(global_position, Vector2(0.7, 0.7));
	get_node("/root/World/region_audio/OGI_OST").stop();
	yield(get_tree().create_timer(1.0), "timeout");
	get_node("/root/World/region_audio/CHANT_OST").play();
	yield(get_tree().create_timer(5.0), "timeout");
	get_node("/root/World/Interactives/END/ogi_speak2/CollisionShape2D").set_deferred("disabled", false);

func endchapter4():
	get_node("/root/World/Player").cinematic = true;
	get_node("/root/World/Camera2D").hook_zoom(global_position, Vector2(0.7, 0.7));
	yield(get_tree().create_timer(1.0), "timeout");
	get_node("/root/World/Interactives/Ogi").hide();
	yield(get_tree().create_timer(3.0), "timeout");
	get_node("/root/World/Interactives/END/fourth_speak/CollisionShape2D").set_deferred("disabled", false);
