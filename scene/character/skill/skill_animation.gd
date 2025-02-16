extends CharacterBody2D

# 技能指示器脚本（释放动画）（有碰撞体）

# 常量
var dir = Vector2.ZERO
var speed = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = dir * speed
	self.rotation = dir.angle()
	move_and_slide()
	pass

# 动画播放完毕，自动删除自己
func _on_skill_animation_animation_finished():
	self.queue_free()
	pass # Replace with function body.


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print(body)
	# 碰撞敌人
	if body.is_in_group("enemy"):
		self.queue_free()
	# 碰撞地块
	if body is TileMap:
		# 获取到当前这个块在墙上的对应位置
		var cords = body.get_coords_for_body_rid(body_rid)
		var tile_data = body.get_cell_tile_data(2, cords)
		var isWall = tile_data.get_custom_data("isWall")
		if isWall:
			self.queue_free()
	pass # Replace with function body.
