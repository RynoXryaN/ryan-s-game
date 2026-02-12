class_name Player
extends CharacterBody2D

@onready var game_manager : GameManager = %GameManager
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var max_health: int = 100
var health: int = max_health


const SPEED : float = 100.0
const JUMP_VELOCITY : float = -275.0

var last_direction := 0.0
var is_dead: bool = false

	# Slam (cannonball) variables
var has_slam: bool = false
var is_slamming: bool = false
var slam_speed: float = 900.0
var slam_cooldown: bool = false

	# Double-Jump variables
var has_double_jump: bool = false
var can_double_jump: bool = false


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	# Add the gravity.
	if not is_on_floor() and not is_slamming:
		velocity += get_gravity() * delta

	# Start slam if midair and pressing down
	if not is_on_floor():
		if has_slam and Input.is_action_just_pressed ("ui_down") and not is_slamming and not slam_cooldown:
			start_slam()
			
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif has_double_jump and can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
			print("Double Jump!")

	if is_on_floor():
		can_double_jump = true
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis ("ui_left", "ui_right")
	last_direction = direction
	if direction:
			velocity.x = direction * SPEED
	else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0:
		animated_sprite_2d.flip_h = false
	if direction < 0:
		animated_sprite_2d.flip_h = true
	

	move_and_slide()
	
	#End slam when hitting the floor
	for i: int in range (get_slide_collision_count()):
		var collision: KinematicCollision2D = get_slide_collision(i)
		var collider: Node = collision.get_collider()
		
		if is_slamming:
			if collision.get_normal().y < -0.9:
				if not collider.is_in_group("slam_target"):
					end_slam()
					break
		
		
	
	handle_animation()



func handle_animation() -> void:
	
	# Once dead, DO NOT change animations anymore
	if is_dead:
		return
	
	if is_on_floor() and last_direction == 0 :
		animated_sprite_2d.play("idle")
	elif is_on_floor() and last_direction != 0 :
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	

func heal(amount: int) -> void:
	health = min(health + amount, max_health)

func take_damage(amount: int) -> void:
	if is_dead:
		return
		
	health -= amount
	
	if health <= 0:
		game_manager.player_died(self)

func die() -> void:
	
	if is_dead:
		return
		
	is_dead = true	
	velocity = Vector2.ZERO
	
	#Engine.time_scale = 0.5
	animated_sprite_2d.play("death")
	
	print("Player died")

func start_slam() -> void:
	print("SLAM STARTED")
	
	is_slamming = true
	velocity.x = 0
	velocity.y = slam_speed
	
func end_slam() -> void:
	print ("SLAM ENDED")
	
	is_slamming = false
	slam_cooldown = true
	
	# Optional Bounce
	velocity.y = -100
	
	await get_tree().create_timer(0.3).timeout
	slam_cooldown = false	
	
func bounce(bounce_velocity: float) -> void:
	velocity.y = bounce_velocity
