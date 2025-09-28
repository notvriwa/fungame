extends CharacterBody2D

var health := 100
@export var speed := 200
@onready var anim := $uwu

func _physics_process(delta):
	var dir_x := 0
	var dir_y := 0

	# ✅ Horizontal input (affects facing direction)
	if Input.is_action_pressed("ui_right"):
		dir_x += 1
	if Input.is_action_pressed("ui_left"):
		dir_x -= 1

	# ✅ Vertical input (does NOT affect facing direction)
	if Input.is_action_pressed("ui_down"):
		dir_y += 1
	if Input.is_action_pressed("ui_up"):
		dir_y -= 1

	# ✅ Movement
	velocity.x = dir_x * speed
	velocity.y = dir_y * speed
	move_and_slide()

	# ✅ Animation & flipping logic (based only on horizontal input)
	if dir_x > 0:
		anim.flip_h = false
		anim.play("walkright")
	elif dir_x < 0:
		anim.flip_h = true
		anim.play("walkright")
	elif dir_y != 0:
		# Moving up/down but not left/right → keep last direction and walk
		anim.play("walkright")
	else:
		# Idle
		anim.stop()

# ✅ Correctly indented damage and death functions
func take_damage(amount):
	health -= amount
	print("Ouch! Health =", health)
	if health <= 0:
		die()

func die():
	print("Game Over!")
	queue_free()
