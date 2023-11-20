extends Node2D

var simple_room_template = preload(GlobalConstant.simple_room_path)
var door_template = preload(GlobalConstant.door_path)
var room_dict = {}

enum Direction{UP, DOWN, LEFT, RIGHT}
const room_color = {
	enter = "#7FFFAA",
	exit  = "#FF0000",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	init(20)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 初始化
func init(size):
	init_basic_room(size)
	init_room_exit()
	pass

# 初始化基本房间
func init_basic_room(size):
	# 初始房间
	var now_position = Vector2.ZERO
	var from_direction = -1
	init_start_room(now_position)
	room_dict[now_position] = true
	var ran = RandomNumberGenerator.new()
	var i = 1
	# 遍历生成房间
	while i < size:
		i += 1 
		var dir = ran.randi_range(0, 3)
		var room = simple_room_template.instantiate()
		# 设置连接上一个房间的门
		# set_door(room, from_direction, now_position)
		# 设置当前房间出去的门
		# set_door(dir, now_position)
		match dir:
			Direction.UP:
				# todo 设置上方一个出口，下一张地图设置下方一个入口
				now_position.y += GlobalConstant.room_height
			Direction.DOWN:
				now_position.y -= GlobalConstant.room_height
			Direction.LEFT:
				now_position.x -= GlobalConstant.room_width
			Direction.RIGHT:
				now_position.x += GlobalConstant.room_width
		print(str(i) + ":" + str(dir))
		from_direction = dir
		if room_dict.has(now_position):
			# 当前位置已存在房间,重新开始循环
			print("当前位置已存在房间,重新开始循环")
			size += 1
		else:
			# 如果是最后一个房间，修改颜色，设置出口
			if i == size:
				init_end_room(now_position)
			else:
				room_dict[now_position] = true
				room.position = now_position
				self.add_child(room)
	pass

# 初始化每个房间的出口
func init_room_exit():
	for pos in room_dict:
		# 判断上面
		if room_dict.has(pos + Vector2(0, GlobalConstant.room_height)):
			set_door(Direction.UP, pos)
		if room_dict.has(pos - Vector2(0, GlobalConstant.room_height)):
			set_door(Direction.DOWN, pos)
		if room_dict.has(pos - Vector2(GlobalConstant.room_width, 0)):
			set_door(Direction.LEFT, pos)
		if room_dict.has(pos + Vector2(GlobalConstant.room_width, 0)):
			set_door(Direction.RIGHT, pos)
	pass

# 初始化开始房间
func init_start_room(position):
	var start_room = simple_room_template.instantiate()
	start_room.room_color = room_color['enter']
	start_room.position = position
	self.add_child(start_room)
	pass
	
# 初始化开始房间
func init_end_room(position):
	var end_room = simple_room_template.instantiate()
	end_room.room_color = room_color['exit']
	end_room.position = position
	self.add_child(end_room)
	pass
	
# 设置门
func set_door(direction, now_position):
	var door = door_template.instantiate()
	match direction:
		Direction.UP:
			door.set_global_rotation_degrees(180)
			now_position.y += GlobalConstant.door_offset_height
		Direction.DOWN:
			now_position.y -= GlobalConstant.door_offset_height
		Direction.LEFT:
			door.set_global_rotation_degrees(-90)
			now_position.x -= GlobalConstant.door_offset_width
		Direction.RIGHT:
			door.set_global_rotation_degrees(90)
			now_position.x += GlobalConstant.door_offset_width
		_:
			return
	door.position = now_position
	self.add_child(door)
	pass
			
	
