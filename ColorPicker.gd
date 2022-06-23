extends ColorPicker



func _ready():
	
	get_child(0).get_child(0).set_size(Vector2(100, 100), true)
	
	get_child(1).hide()
	get_child(2).hide()
	get_child(3).hide()
	get_child(4).hide()
	get_child(5).hide()
	get_child(6).hide()
	get_child(7).hide()
