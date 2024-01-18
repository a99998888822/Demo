extends Node2D

@onready var weapon_template = preload("res://scene/temp/weapon/weapon.tscn")

var weapon_redius = 230
const weapon_level = {
	level_1 = "#b0c3d9",
	level_2 = "#4b69ff",
	level_3 = "#d32ce6",
	level_4 = "#8847ff",
	level_5 = "#eb4b4b",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# 随机数生成器
	var ran = RandomNumberGenerator.new()
	var weapon_num = ran.randi_range(1, 6)
	print("随机生成武器把数:" + str(weapon_num))
	# 每把武器偏转的角度
	var unit = TAU / weapon_num
	# 动态创建武器
	for i in weapon_num:
		var weapon = weapon_template.instantiate()
		var selected_level = 'level_' + str(ran.randi_range(1, 5))
		weapon.selected_level = weapon_level[selected_level]
		var weapon_rad = unit * i
		var end_pos = weapon.position + Vector2(weapon_redius, 0).rotated(weapon_rad)
		weapon.position = end_pos
		self.add_child(weapon)
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
