extends CharacterBody2D

var canMoving = false
var speed = 1000
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	self.set_collision_layer_value(5, false)
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	if canMoving:
		var dir = (player.position - self.position).normalized()
		velocity = dir * speed
		move_and_slide()
	pass
	
func pick():
	canMoving = true
	pass
	
func pick_up():
	self.queue_free()
	pass
	
'''
options.box 掉落物父级
options.ani_name 掉落物名称
options.position 掉落物生成坐标
options.scale 掉落物缩放等级
'''
func gen_drop_item(options):
	if !options.has("box"):
		options.box = GameMain.duplicate_node
	var drop_item = self.duplicate()
	options.box.add_child.call_deferred(drop_item)
	drop_item.show.call_deferred()
	drop_item.set_collision_layer_value.call_deferred(5, true)
	drop_item.scale = options.scale if options.has("scale") else Vector2(1, 1)
	drop_item.position = options.position
	drop_item.get_node("all_animation").play(options.ani_name)
	pass
	
