extends Node2D

@onready var ani = $AnimatedSprite2D
var room_color = "#ffffff"

# Called when the node enters the scene tree for the first time.
func _ready():
	ani.material.set_shader_parameter("room_color", Color(room_color))
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
