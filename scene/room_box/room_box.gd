extends Node2D

var simple_room = preload(GlobalConstant.room_box_path)
enum direction{up, down, left, right}

# Called when the node enters the scene tree for the first time.
func _ready():
	init_random_room(10)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_random_room(size):
	var ran = RandomNumberGenerator.new()
	for i in range(size):
		var dir = ran.randi_range(0, 4)
		print(dir)
	
	pass
