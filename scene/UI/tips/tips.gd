extends CanvasLayer

@onready var margin_container = $MarginContainer
@onready var label = $MarginContainer/Panel/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	if margin_container.is_visible():
		var mouse_position = margin_container.get_global_mouse_position()
		var mc_position = Vector2(mouse_position.x, mouse_position.y-label.size.y)
		margin_container.position = mc_position
	pass

# 初始化tips内容
func init(tips_text):
	label.text = tips_text
	pass

# 当鼠标接触到图标
func _on_area_2d_mouse_entered():
	# 调整一下tips框框的大小
	var mc_size = label.size
	mc_size.x = 200
	mc_size.y += 20
	margin_container.size = mc_size
	margin_container.show()
	pass # Replace with function body.


# 当鼠标停止接触图标
func _on_area_2d_mouse_exited():
	margin_container.hide()
	pass # Replace with function body.
