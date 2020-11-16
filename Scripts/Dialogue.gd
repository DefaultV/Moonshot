extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var arrownext;
func _ready():
	percent_visible = 0;
	arrownext = get_node("../Dialogue_rect/Arrownext")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	txtscroll(delta)
#	pass

func resetscroll():
	percent_visible = 0;
	arrownext.hide()

func txtscroll(delta):
	if (percent_visible < 1 and visible):
		percent_visible += delta * 0.5;
		if percent_visible >= 1:
			arrownext.show()
