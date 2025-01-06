extends CharacterBody2D

@onready var label = $Label

var speed = 100
var content = ""
var color = ""
var thread : Thread

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = content
	label.material.set_shader_parameter("show_color", Color(color))
	# 使其居中
	# label.position.x -= (label.size.x /2)
	thread = Thread.new()
	thread.start(wait_free)
	pass

func wait_free():
	await get_tree().create_timer(1.0).timeout
	queue_free()
	pass

func _exit_tree():
	thread.wait_to_finish()
	pass

func _process(_delta):
	# 显示文字逐渐变淡
	#var opacity = timer.time_left
	#label.material.set_shader_parameter("show_opacity", opacity)
	# 向上
	self.position.y -= _delta * speed
	pass
