extends Node2D

@onready var tilemap = $TileMap
var weapon_node = Object.new

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# 生成随机的装饰地块
func random_tile():
	# 清除现有的装饰地块
	tilemap.clear_layer(1)
	var bg1_cells = tilemap.get_used_cells(0)
	var ran = RandomNumberGenerator.new()
	for cell_pos in bg1_cells:
		var num = ran.randi_range(0, 100)
		if num <= 5:
			# 层级 起始坐标 tilemap素材的索引 索引所处图块的范围  
			tilemap.set_cell(1, cell_pos, 1, Vector2i(18, 1))
	pass


func _on_game_ui_round_end():
	get_tree().paused = true
	$scene_update.init()
	pass
