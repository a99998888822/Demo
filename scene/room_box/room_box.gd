extends Node2D

var simple_room_template = preload(GlobalConstant.simple_room_path)
var room_dict = {}

enum Direction{UP, DOWN, LEFT, RIGHT}
const room_color = {
	enter = "#7FFFAA",
	exit  = "#FF0000",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	init_random_room(20)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_random_room(size):
	# 初始房间
	var now_position = Vector2.ZERO
	init_start_room(now_position)
	room_dict[now_position] = true
	var ran = RandomNumberGenerator.new()
	var i = 1
	# 遍历生成房间
	while i < size:
		i += 1 
		var dir = ran.randi_range(0, 3)
		var room = simple_room_template.instantiate()
		match dir:
			Direction.UP:
				now_position.y += GlobalConstant.room_height
			Direction.DOWN:
				now_position.y -= GlobalConstant.room_height
			Direction.LEFT:
				now_position.x -= GlobalConstant.room_width
			Direction.RIGHT:
				now_position.x += GlobalConstant.room_width
		print(str(i) + ":" + str(dir))
		if room_dict.has(now_position):
			# 当前位置已存在房间,重新开始循环
			print("当前位置已存在房间,重新开始循环")
			size += 1
		else:
			# 如果是最后一个房间，修改颜色，设置出口
			if i == size:
				room.room_color = room_color['exit']
			else:
				room_dict[now_position] = true
				room.position = now_position
				self.add_child(room)
	pass

# 初始化开始房间
func init_start_room(position):
	
# 初始化开始房间
func init_start_room(position):
	var start_room = simple_room_template.instantiate()
	start_room.room_color = room_color['enter']
	start_room.position = position
	self.add_child(start_room)
	pass
	
