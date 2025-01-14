extends CharacterBody2D

@onready var wizardAni = $WizardAnimation

var dir = Vector2.ZERO # 移动方向
var flip = false # 翻转
var is_attacking = false # 攻击状态
var target_pos = Vector2.ZERO # 移动的目标地址
var speed = 300 # 速度
var relative_pos_min_limit = 5 # 位移的阈值

# Called when the node enters the scene tree for the first time.
func _ready():
	target_pos = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(_delta):
	# 用鼠标控制任务移动
	var self_pos = position
	var relative_pos = target_pos - self_pos
	wizardAni.flip_h = flip
	# 控制攻击和移动
	if is_attacking:
		wizardAni.play("wield_sword") # 播放攻击动画
	elif relative_pos.length() > relative_pos_min_limit: # 判断是否存在位移
		# 切换到跑动动画
		wizardAni.play("running")
		dir = relative_pos.normalized()
		velocity = dir * speed
		
		# 计算旋转角度，使动画面朝鼠标位置
		# var angle = dir.angle()
		# rotation = angle # 设置角色的旋转角度
		
		# 有位移才翻转控制翻转
		if target_pos.x < self_pos.x:
			# rotation = angle + PI # 镜像翻转
			flip = true
		else:
			# rotation = angle # 正常旋转
			flip = false
			
		move_and_slide()
	else:
		rotation = 0
		wizardAni.play("idle") # 切换到待机动画
	pass
	
func _input(event):
	# 鼠标右键控制移动
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		target_pos = get_global_mouse_position()
		GameMain.animation_scene_obj.run_animation({
			"ani_name": "move_indicator",
			"position": target_pos,
			"scale": Vector2(0.5, 0.5)
		})
	# 键盘A键控制挥剑
	if event is InputEventKey and event.key_label == KEY_A and event.is_pressed():
		is_attacking = true # 设置攻击状态
		# 连接攻击动画完成信号
		# wizardAni.get_animation("wield_sword").connect("animation_finished", self, "_on_attack_finished")

		
# 方向键移动
func move_by_button():
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
	# 控制翻转
	wizardAni.flip_h = flip
	# 控制移动
	if dir.length() > 0: # 判断是否存在位移
		wizardAni.play("running") # 切换到跑动动画
		dir = dir.normalized()
		velocity = dir * speed
		move_and_slide()
	else:
		wizardAni.play("idle") # 切换到待机动画
	pass

# 接收攻击动画播放完成
func _on_wizard_animation_animation_finished():
	# 如果是攻击类的动画，则取消暂停移动的状态位
	if is_attacking:
		is_attacking = false
		# target_pos = position
	pass # Replace with function body.
