extends CharacterBody2D
@export var speed := 150
@export var attack_distance := 40
@export var attack_cooldown := 1.0  # seconds

var player: Node2D
var last_attack_time := -1.0
@onready var anim := $AnimatedSprite2D
var dis = 0.
func _ready():
	player = get_parent().get_node("pablo")

func _physics_process(delta):
	if not player:
		return

	# Move toward Pablo
	var direction = player.get_children()[2].global_position - global_position
	dis = direction.x*direction.x + direction.y*direction.y
	print(player.get_children()[2].global_position)
	print(global_position)
	if direction.length() > 0:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# Flip sprite
	if velocity.x > 0:
		anim.flip_h = false
	elif velocity.x < 0:
		anim.flip_h = true
	anim.play("walk")
		
func attack_player():
	if player.has_method("take_damage") && dis < 10000:
		player.take_damage(1)
