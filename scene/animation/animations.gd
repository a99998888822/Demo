extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

'''
option.box 动画父级
option.ani_name 动画名称
option.position 动画生成坐标
option.scale 动画缩放登记
'''
func run_animation(options):
	var ani_temp = self.duplicate()
	options.box.add_child(ani_temp)
	ani_temp.show()
	ani_temp.scale = options.scale if options.has("scale") else Vector2(1, 1)
	ani_temp.position = options.position
	ani_temp.get_node("all_animation").play(options.ani_name)
	pass

func _on_all_animation_animation_finished():
	self.queue_free()
	pass # Replace with function body.
