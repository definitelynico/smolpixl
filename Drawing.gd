extends Node2D



onready var currentColorBox = get_node("/root/Test3/ColorBoxContainer/CurrentColor")
onready var colorPickerColor = get_node("/root/Test3/PanelContainer/ColorPicker")

var penSize = 10
var currentColor = Color(0, 0, 0, 1)

var currentMousePos = Vector2()
var lastMousePos = Vector2()

var canDraw = true
var drawPosition = []
var drawColor = []
var usedColors = []
var index = 0


####################################################################################################


func _input(event):
	if event is InputEventMouseMotion:
		currentMousePos = event.position / penSize
		currentMousePos = currentMousePos.floor() * penSize
		index = drawPosition.find(currentMousePos)
	if Input.is_action_pressed("LMB") && canDraw:
		_penDraw()
	if Input.is_action_pressed("RMB") && canDraw:
		_penErase()
	if Input.is_action_just_pressed("Undo"):
		_undoDemo()
	if Input.is_action_just_pressed("MMB"):
		if drawPosition.has(currentMousePos):
			currentColor = drawColor[index]
			currentColorBox.color = currentColor
			colorPickerColor.color = currentColor
	update()


func _penDraw():
	if !drawPosition.has(currentMousePos):
		drawPosition.append(currentMousePos)
		drawColor.append(currentColor)
	else:
		drawPosition.remove(index)
		drawColor.remove(index)
		drawPosition.append(currentMousePos)
		drawColor.append(currentColor)


func _penErase():
	if drawPosition.has(currentMousePos):
		drawPosition.remove(index)
		drawColor.remove(index)


func _draw():
	for p in range(0, drawPosition.size()):
		draw_rect(Rect2(drawPosition[p], Vector2(penSize, penSize)), drawColor[p])

	draw_rect(Rect2(currentMousePos, Vector2(penSize, penSize)), currentColor)


func _on_ColorPicker_color_changed(color):
	currentColor = color
	currentColorBox.color = color


func _on_Save_pressed():
	yield(VisualServer, "frame_post_draw")
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	img.resize(48, 48, Image.INTERPOLATE_NEAREST)
	var tmpDl = img.save_png_to_buffer()
	JavaScript.download_buffer(tmpDl, "Asset_48px.png")


func _on_Clear_pressed():
	drawPosition.clear()
	drawColor.clear()


func _on_Chaos_pressed():
	drawColor.shuffle()


func _undoDemo():
	var dps = drawPosition.size() - 1
	drawPosition.remove(dps)
	drawColor.remove(dps)


func _on_ColorPicker_mouse_entered():
	canDraw = false


func _on_Canvas_mouse_entered():
	canDraw = true

