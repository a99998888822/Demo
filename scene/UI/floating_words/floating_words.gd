extends CharacterBody2D

@onready var label = $Label

var speed = 100
var text = ""
var color = ""
var thread : Thread


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = text
	label.material.set_shader_parameter("show_color", Color(color))
	label.position.x -= (label.size.x /2)
	velocity = Vector2.UP * speed
	move_and_slide()
	thread = Thread.new()
	thread.start(wait_free)


# The argument is the bound data passed from start().
func wait_free():
	# Print the userdata ("Wafflecopter")
	print("float_words free itself")
	await get_tree().create_timer(1.0).timeout
	queue_free()
	pass # Replace with function body.

func _exit_tree():
	thread.wait_to_finish()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# 显示文字逐渐变淡
	#var opacity = timer.time_left
	#label.material.set_shader_parameter("show_opacity", opacity)
	pass
