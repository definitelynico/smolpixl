extends Node2D


func _ready():
	$Canvas.rect_global_position = get_parent().get_node("ViewportContainer").rect_global_position
