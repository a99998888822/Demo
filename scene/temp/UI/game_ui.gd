extends CanvasLayer

# 属性
@onready var hp_value_bar = $%hp_value_bar
@onready var exp_value_bar = $%exp_value_bar
@onready var gold = $%gold
# 回合
@onready var now_round = $countdown/now_round
@onready var time_show = $countdown/time_show
@onready var timer = $countdown/Timer
@onready var gold_tips = $gold/tips

# 角色与信号
var player
signal round_end
var now_round_num = 0:
	set(val):
		# 设置当前波数时的操作
		now_round_num = val
		now_round.text = "第%s波" % [str(val)]
var round_time = 0:
	set(val):
		# 设置当前波数时的操作
		round_time = val
		time_show.text = str(val)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	init_round()
	# 初始化tips
	gold_tips.init(tr("gold_tips"))
	pass # Replace with function body.


# 初始回合和倒计时
func init_round():
	now_round_num += 1
	round_time = (5000 + now_round_num * 5)
	timer.start()
	pass

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	hp_value_bar.max_value = player.max_hp
	hp_value_bar.value = player.now_hp
	hp_value_bar.get_node("Label").text = str(player.now_hp) + '/' + str(player.max_hp)
	
	exp_value_bar.max_value = player.max_exp
	exp_value_bar.value = player.now_exp
	exp_value_bar.get_node("Label").text = 'Lv.' + str(player.level)
	
	gold.text = str(player.gold)
	pass

# 计时器每过1秒
func _on_timer_timeout():
	round_time -= 1
	if round_time <= 0:
		timer.stop()
		emit_signal("round_end")
	pass # Replace with function body.
