extends CharacterBody2D

@onready var playerAni = $AnimatedSprite2D

var dir = Vector2.ZERO
var speed = 300
# 翻转
var flip = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# 鼠标的移动方式
	var mouse_pos = get_global_mouse_position()
	var self_pos = position
	# 控制翻转
	if mouse_pos.x > position.x:
		flip = false
	else:
		flip = true
	playerAni.flip_h = flip	
	# 控制移动
	dir = (mouse_pos -self_pos).normalized()
	velocity = dir * speed
	move_and_slide()
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print("按下鼠标左键")
	pass
