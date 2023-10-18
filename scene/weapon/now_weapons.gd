extends Node2D

var weapon_redius = 230
var weapon_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# 随机数生成器
	var ran = RandomNumberGenerator.new()
	var weapon_num = ran.randi_range(1, 6)
	print("随机生成武器把数:" + str(weapon_num))
	# 每把武器偏转的角度
	var unit = TAU / weapon_num
	var weapon_default = self.get_child(0, false)
	var weapon_template = weapon_default.duplicate()
	# 删除默认武器
	weapon_default.free()
	
	for i in weapon_num:
		# 这里复制的时候，weapon已经加入节点树了，所以后续_ready()方法不会再执行
		var weapon = weapon_template.duplicate()
		# var selected_level = 'level_' + str(ran.randi_range(1, 5))
		# print("随机生成颜色:" + selected_level)

		var weapon_rad = unit * i
		var end_pos = weapon.position + Vector2(weapon_redius, 0).rotated(weapon_rad)
		weapon.position = end_pos
		self.add_child(weapon)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
