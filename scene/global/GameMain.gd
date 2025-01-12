extends Node

# 配置中设置自动加载

# 动画
var animation_scene = preload("res://scene/animation/animations.tscn")
var animation_scene_obj = null 
# 物体（静止）
# var drop_items_scene = preload("res://scene/temp/drop_items/drop_items.tscn")
# var drop_items_scene_obj = null 

var duplicate_node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_scene_obj = animation_scene.instantiate()
	add_child(animation_scene_obj)
	# drop_items_scene_obj = drop_items_scene.instantiate()
	# add_child(drop_items_scene_obj)
	
	var node2d = Node2D.new()
	node2d.name = "duplicate_node"
	get_window().add_child.call_deferred(node2d)
	duplicate_node = node2d
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(__delta):
	pass
