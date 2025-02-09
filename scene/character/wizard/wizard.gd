extends CharacterBody2D

@onready var wizardAni = $WizardAnimation
@onready var skill_indicator = $SkillIndicator

# 变量设置
var dir = Vector2.ZERO # 移动方向
var flip = false # 翻转
var target_pos = Vector2.ZERO # 移动的目标地址
var skill_target_pos = Vector2.ZERO # 技能的目标地址


# 常量设置
var relative_pos_min_limit = 5 # 位移的阈值
var speed = 300 # 速度
var skill_indicator_distance = 200 # 技能指示器的距离

# 状态位
var is_attacking = false # 攻击状态
var is_skill_indicator = false # 技能状态

# Called when the node enters the scene tree for the first time.
func _ready():
	target_pos = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(_delta):
	character_animation_controller()
	skill_indicator_controller()
	pass

# 人物动画控制逻辑
func character_animation_controller():
	# 用鼠标控制人物移动
	var self_pos = position
	var relative_pos = target_pos - self_pos
	# 翻转控制
	if target_pos.x < self_pos.x:
		flip = true
	else:
		flip = false
	# 技能控制的翻转
	if is_attacking:
		if skill_target_pos.x < self_pos.x:
			flip = true
		else:
			flip = false
	wizardAni.flip_h = flip
	# 控制攻击和移动
	if is_attacking:
		# 播放攻击动画
		wizardAni.play("wield_sword")
	elif relative_pos.length() > relative_pos_min_limit: # 判断是否存在位移
		# 切换到跑动动画
		wizardAni.play("running")
		dir = relative_pos.normalized()
		velocity = dir * speed
		move_and_slide()
	else:
		# 切换到待机动画
		wizardAni.play("idle") 

# 技能指示器控制逻辑
func skill_indicator_controller():
	if is_skill_indicator:
		var self_pos = position
		var indicator_pos = get_global_mouse_position()
		# 计算指向鼠标的方向
		var direction = (indicator_pos - self_pos).normalized()
		# 设置技能指示器的位置，保持与角色的距离为 skill_indicator_distance（这个position是相对距离）
		skill_indicator.position = Vector2(0, -120) + direction * skill_indicator_distance
		# print("角色的位置：", self_pos, "，方向：", direction, "指示器位置：", skill_indicator.position)
		# 设置技能指示器的朝向
		skill_indicator.rotation = direction.angle() # 使指示器朝向鼠标位置
		skill_indicator.show()
	else:
		skill_indicator.hide()

# 输入
func _input(event):
	# 鼠标右键控制移动
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		target_pos = get_global_mouse_position()
		GameMain.animation_scene_obj.run_animation({
			"ani_name": "move_indicator",
			"position": target_pos,
			"scale": Vector2(0.5, 0.5)
		})
	# 鼠标左键控制技能释放指示器
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		skill_target_pos = get_global_mouse_position()
		is_attacking = true # 设置攻击状态
		is_skill_indicator = false # 关闭技能指示器
	# 键盘A键控制挥剑（打开指示器）
	if event is InputEventKey and event.key_label == KEY_A and event.is_pressed():
		if is_skill_indicator:
			is_skill_indicator = false
		else:
			is_skill_indicator = true 
		
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

# 接收动画播放完成
func _on_wizard_animation_animation_finished():
	# 如果是攻击类的动画，则取消暂停移动的状态位
	# print(Time.get_time_string_from_system(), wizardAni.get_animation())
	if wizardAni.get_animation() == "wield_sword":
		is_attacking = false
		# target_pos = position
	pass # Replace with function body.
