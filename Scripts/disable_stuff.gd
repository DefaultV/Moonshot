extends Area2D

func _ready():
	connect("body_entered",self, "_on_breakwall_body_entered");
	
export var stuff_to_disable:PoolStringArray = [];

func _on_breakwall_body_entered(body):
	if body.name == "Player":
		print("player break wall");
		disable_recursive(stuff_to_disable);

func disable_recursive(nodepatharray):
	for nodepath in nodepatharray:
			var node = get_node(nodepath);
			node.hide();
			for child in node.get_children():
				if child.get_class() == "CollisionShape2D":
					child.set_deferred("disabled", true);
