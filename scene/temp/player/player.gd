extends Player

@onready var playerAni = $PlayerAnimation
@onready var floating_words = preload("res://scene/UI/floating_words/floating_words.tscn")

var dir = Vector2.ZERO # 移动方向
var flip = false # 翻转

var level_add_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	choose_player("player2")
	init_attr()
	pass # Replace with function body.

# 初始化属性
func init_attr():
	speed = 500
	now_hp = 10
	max_hp = 10
	max_exp = 5
	now_exp = 0
	level = 1
	gold = 0
	pass

# 鼠标的移动方式
func mouse_move():
	var mouse_pos = get_global_mouse_position()
	var self_pos = position
	# 控制翻转
	if mouse_pos.x > position.x:
		flip = false
	else:
		flip = true
	playerAni.flip_h = flip
	# 控制移动
	dir = (mouse_pos -self_pos).normalized()
	velocity = dir * speed
	move_and_slide()
	pass

# Called every frame. '_delta' is the elapsed time since the previous frame.
# todo 待测试
@warning_ignore("unused_parameter")
func _process(_delta):
	# 按照方向键移动
	dir = Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		dir.y += -1
	if Input.is_action_pressed("ui_left"):
		dir.x += -1
		flip = true
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
		flip = false
	playerAni.flip_h = flip	
	# 控制移动
	dir = dir.normalized()
	velocity = dir * speed
	move_and_slide()
	pass

# 动态角色帧生成 先使用固定的960*240尺寸
func choose_player(player):
	var asset_path = "res://scene/temp/player/assets/"
	playerAni.sprite_frames.clear_all()
	var sprite_frame_custom = SpriteFrames.new()
	# sprite_frame_custom.add_animation(player)
	# sprite_frame_custom.set_animation_loop(player, true)
	# 完整雪碧图的大小
	var texture_size = Vector2(960, 240)
	# 单张动作的雪碧图的大小
	var sprite_size = Vector2(240, 240)
	# 获取根据type指向的雪碧图完整路径
	var full_texture: Texture = load(asset_path + player + "/" + player + "-sheet.png")
	# 选择雪碧图->切个->生成帧动画
	var num_columns = int(texture_size.x / sprite_size.x)
	var num_rows = int(texture_size.y / sprite_size.y)
	for x in range(num_columns):
		for y in range(num_rows):
			var frame = AtlasTexture.new()
			frame.atlas = full_texture
			frame.region = Rect2(Vector2(x,y) * sprite_size, sprite_size)
			sprite_frame_custom.add_frame("default", frame)
	playerAni.sprite_frames = sprite_frame_custom
	playerAni.play("default")
	pass

# 监听输入
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print("按下鼠标左键")
	pass
	
func _on_drop_item_area_body_entered(body):
	if body.is_in_group("drop_item"):
		if body.has_method("pick"):
			var floating_words_obj = floating_words.instantiate()
			floating_words_obj.content = "gold 1"
			floating_words_obj.color = "#FFFF00"
			self.add_child(floating_words_obj)
			body.pick()
	pass # Replace with function body.

func _on_stop_area_body_entered(body):
	if body.is_in_group("drop_item"):
		self.gold += (1 + self.gold_get)
		self.now_exp += (1 + self.exp_get)
		if self.now_exp >= self.max_exp:
			self.now_exp = 0
			self.level += 1
			self.level_add_num += 1
			self.max_exp *= 2
		if body.has_method("pick_up"):
			body.pick_up()
	if body.is_in_group("enemy"):
		now_hp -= 1
	pass # Replace with function body.
