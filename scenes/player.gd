extends CharacterBody2D

const ACCELERATION = 600.0
const FRICTION = 1000.0
const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite_2d = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()

	var input_axis = Input.get_axis("ui_left", "ui_right")
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)	
	update_animations(input_axis)
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func handle_jump():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
			
func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
	if not is_on_floor():
		animated_sprite_2d.play("jump")
