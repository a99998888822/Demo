extends Node2D

var simple_room_template = preload(GlobalConstant.simple_room_path)
enum Direction{UP, DOWN, LEFT, RIGHT}

# Called when the node enters the scene tree for the first time.
func _ready():
	init_random_room(10)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_random_room(size):
	# 初始房间
	var now_position = Vector2.ZERO
	var simple_room = simple_room_template.instantiate()
	simple_room.position = now_position
	self.add_child(simple_room)
	var ran = RandomNumberGenerator.new()
	# 遍历生成房间
	for i in range(size):
		var dir = ran.randi_range(0, 3)
		var room = simple_room.duplicate()
		match dir:
			Direction.UP:
				now_position.y += GlobalConstant.room_height
			Direction.DOWN:
				now_position.y -= GlobalConstant.room_height
			Direction.LEFT:
				now_position.x -= GlobalConstant.room_width
			Direction.RIGHT:
				now_position.x += GlobalConstant.room_width
		print(dir)
		if self.get
		room.position = now_position
		self.add_child(room)
	pass
