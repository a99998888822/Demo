extends CharacterBody2D

var dir = null
var speed = 300
var target = null
var hp = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		dir = (target.global_position - self.global_position).normalized()
		velocity = dir * speed
		move_and_slide()
	pass

# 受击函数
func enemy_hurt(hurt):
	var final_hurt = (hurt + target.basic_hurt) * target.basic_hurt_multiple
	self.hp -= final_hurt
	enemy_flash()
	GameMain.animation_scene_obj.run_animation({
		"box": self,
		"ani_name": "enemies_hurt",
		"position": Vector2(1, 1),
		"scale": Vector2(1, 1)
	})
	if self.hp <= 0:
		enemy_dead()
	pass
	
func enemy_flash():
	$AnimatedSprite2D.material.set_shader_parameter("flash_opacity", 0.7)
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("flash_opacity", 0 )
	pass
	
# 消灭函数
func enemy_dead():
	GameMain.animation_scene_obj.run_animation({
		"ani_name": "enemies_dead",
		"position": self.global_position,
		"scale": Vector2(0.7, 0.7)
	})
	GameMain.drop_items_scene_obj.gen_drop_item({
		"ani_name": "gold",
		"position": self.global_position,
		"scale": Vector2(3, 3)
	})
	self.queue_free()
	pass
