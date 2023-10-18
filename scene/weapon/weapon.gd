extends Node2D

@onready var weaponAni = $AnimatedSprite2D

const weapon_level = {
	level_1 = "#b0c3d9",
	level_2 = "#4b69ff",
	level_3 = "#d32ce6",
	level_4 = "#8847ff",
	level_5 = "#eb4b4b",
}
		
# Called when the node enters the scene tree for the first time.
func _ready():
	var ran = RandomNumberGenerator.new()
	var selected_level = 'level_' + str(ran.randi_range(1, 5))
	print("随机生成颜色:" + selected_level)
	weaponAni.material.set_shader_parameter("color", 
		Color(weapon_level[selected_level]))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
