extends Node2D

var simple_room_template = preload(GlobalConstant.simple_room_path)
enum Direction{UP, DWON, LEFT, RIGHT}

# Called when the node enters the scene tree for the first time.
func _ready():
	init_random_room(10)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_random_room(size):
	# 初始房间
	var simple_room = simple_room_template.instantiate()
	self.add_child(simple_room)
	var ran = RandomNumberGenerator.new()
	for i in range(size):
		var dir = ran.randi_range(0, 3)
		match dir:
			Direction.UP:
				print("up")
	pass
