extends Sprite



func _ready():
	get_viewport().audio_listener_enable_2d = true
	$AudioStreamPlayer2D.play()
	
	
func _process(delta):
	if self.position.x > 0 - self.texture.get_width():
		move_local_x(-1)
	else:
		self.position.x = get_viewport().get_visible.rect().size.x
