extends CanvasLayer

@onready var attr_item_choose = $attr_item_choose
@onready var attr_item_template = $attr_item_choose/attr_item_template

@onready var attr_list  = $attr/MarginContainer/ScrollContainer/attr_list
@onready var attr_template = $attr/MarginContainer/ScrollContainer/attr_list/attr_template

@onready var refresh_btn = $refresh
@onready var upgrade = $upgrade
@onready var continue_btn = $continue

var player = null
signal continue_game

const ATTR_GROUP = {
	"attack":{
		"name": "攻击力",
		"type1": {
			"name": "基础伤害叠加",
			"img": "basic_hurt"
		},
		"type2": {
			"name": "基础伤害倍数",
			"img": "basic_hurt"
		},
	},
	"speed":{
		"name": "速度",
		"type1": {
			"name": "移动速度",
			"img": "speed"
		}
	},
	"hp":{
		"name": "血量",
		"type1": {
			"name": "最大血量",
			"img": "max_hp"
		}
	},
	"get_add":{
		"name": "获取叠加",
		"type1": {
			"name": "金币获取叠加",
			"img": "gold_get"
		},
		"type2": {
			"name": "经验获取叠加",
			"img": "exp_get"
		},
	},
}

const attr_data = {
	"basic_hurt": {
		"group": ATTR_GROUP.attack,
		"type": "type1",
		"range": "1-5"
	},
	"basic_hurt_multiple": {
		"group": ATTR_GROUP.attack,
		"type": "type2",
		"range": "2-4"
	},
	"speed": {
		"group": ATTR_GROUP.speed,
		"type": "type1",
		"range": "50-200"
	},
	"max_hp": {
		"group": ATTR_GROUP.hp,
		"type": "type1",
		"range": "1-10"
	},
	"gold_get": {
		"group": ATTR_GROUP.get_add,
		"type": "type1",
		"range": "1-5"
	},
	"exp_get": {
		"group": ATTR_GROUP.get_add,
		"type": "type2",
		"range": "1-5"
	},
}

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.

# 初始化
func init():
	# 设置本地化-选择中文
	TranslationServer.set_locale('zh')
	self.show()
	# 升级相关菜单的显示
	if player.level_add_num > 0:
		# 如果用户升级了，则展示
		attr_item_choose.show()
		refresh_btn.show()
		upgrade.show()
		# 加载属性选择
		gen_attr_choose()  
	else:
		# 如果用户没升级，则仅展示继续按钮
		continue_btn.show()
	# 加载角色属性
	load_player_attr()
	pass
	
# 加载属性选择
func gen_attr_choose():
	var keys = attr_data.keys()
	for item in range(4):
		# 获取一个随机的属性选项
		var num = randi_range(0, keys.size()-1)
		var attr_choosen_data = attr_data[keys[num]].group[attr_data[keys[num]].type]
		var range = attr_data[keys[num]].range.split("-")
		var attr_value = randi_range(int(range[0]), int(range[1]))
		# 如果已存在子节点，则修改子节点属性
		print("size is " + str(attr_item_choose.get_children().size()) + "item is "+ str(item))
		var attr_item
		if attr_item_choose.get_children().size() > item:
			attr_item = attr_item_choose.get_child(item)
		else:
			# 如果不存在子节点，则新建
			attr_item = attr_item_template.duplicate()
		# 设置节点树的相关属性
		attr_item.get_node("MarginContainer/HBoxContainer/upgrade_img").texture = load("res://scene/temp/scenes/scene_update/assets/"+ attr_choosen_data.img +".png")
		attr_item.get_node("MarginContainer/HBoxContainer/VBoxContainer/upgrade_name").text = attr_choosen_data.name
		attr_item.get_node("upgrade_value").text = "[color=green]" + str(attr_value) +"[/color] " + attr_choosen_data.name
		var pressed_singal = attr_item.get_node("upgrade_choosen_btn").pressed
		# 如果该信号已经绑定了该方法，则取消绑定重新绑（todo 考虑下emit？）
		if pressed_singal.is_connected(choose_attr): 
			pressed_singal.disconnect(choose_attr)
		pressed_singal.connect(choose_attr.bind({
			"key": keys[num],
			"attr": attr_data[keys[num]],
			"val": attr_value
		}))
		if attr_item_choose.get_children().size() <= item:
			attr_item_choose.add_child(attr_item)
	pass
	
# 绑定按钮点击事件
func choose_attr(attr_info):
	player[attr_info.key] += attr_info.val
	player.level_add_num -= 1
	# 如果用户升级次数用完，则隐藏升级相关信息，展示继续按钮
	if player.level_add_num == 0:
		attr_item_choose.hide()
		refresh_btn.hide()
		upgrade.hide()
		continue_btn.show()
	else:
		gen_attr_choose()
	# 重新加载一次用户属性
	load_player_attr()
	pass

# 加载角色属性
func load_player_attr():
	# todo 这里有优化空间
	# 隐藏模板节点
	attr_template.hide()
	# 清除除模板节点以外的其他节点
	for item in attr_list.get_children():
		if item.is_visible():
			attr_list.remove_child(item)
			item.queue_free()
	# 读取角色脚本的属性
	var prop_list = player.get_script().get_base_script().get_script_property_list()
	for prop in prop_list:
		if prop.name.rfind(".gd") == -1:
			var attr_item = attr_template.duplicate()
			attr_item.get_node("attr_name").text = tr(prop.name)
			attr_item.get_node("attr_value").text = str(player[prop.name])
			attr_item.show()
			attr_list.add_child(attr_item)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 点击刷新按钮
func _on_refresh_pressed():
	if player.gold >= 2:
		player.gold -= 2
		gen_attr_choose()
		load_player_attr()
	pass # Replace with function body.

# 点击继续按钮
func _on_continue_pressed():
	emit_signal("continue_game")
	pass # Replace with function body.
