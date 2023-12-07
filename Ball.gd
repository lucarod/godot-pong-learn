extends KinematicBody2D

signal exploded

export var initial_speed = 300
export var acceleration = 50
var speed = initial_speed

var hit_counter = 0
var max_hits = 12
var direction = Vector2()

var trail_length = 30
onready var trail = $Trail/Points

func _ready():
	trail.clear_points()
	randomize()

func set_start_direction():
	var random_x = 0
	
	if randi()%10 < 5:
		random_x = 1
	else:
		random_x = -1
	
	direction = Vector2(random_x, rand_range(1, -1))
	direction = direction.normalized() #* speed
	
func _physics_process(delta):
	if trail.points.size() > trail_length:
		trail.remove_point(0)
	trail.add_point(position)
	
	var y = direction.y * speed
	var collision = move_and_collide( direction * delta * speed)
	if collision:
		direction = direction.bounce( collision.normal )

		if collision.collider.is_in_group("racket"):
			y = (direction.y * speed) / 2 + collision.collider_velocity.y

			if hit_counter  < max_hits:
				hit_counter  += 1
				
			$RacketSound.play()
		else:
			y = direction.y * speed
			$WallSound.play()

	direction = Vector2( direction.x * speed, y ).normalized()
	speed = initial_speed + hit_counter * acceleration
			
func reset():
	position = Vector2(683, 384)
	direction = Vector2()
	hit_counter = 0
	trail.clear_points()
	speed = initial_speed
	$Sprite.set_visible(true)
	
func explode():
	speed = 0
	trail.clear_points()
	$GoalExplosion.set_emitting(true)
	$Sprite.set_visible(false)
	$ExplosionTimer.start($GoalExplosion.lifetime + 0.2)


func _on_ExplosionTimer_timeout():
	emit_signal("exploded")
