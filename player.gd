extends CharacterBody2D

signal health_depleted

var health = 100.0

var gun1var
var gun2var
var gun3var

func _ready():
	gun1var = $Gun
	gun2var = $gun2
	gun3var = $Gun3
	remove_child(gun2var)
	remove_child(gun3var)

func _physics_process(delta: float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		$HappyBoo.play_walk_animation()
	else:
		$HappyBoo.play_idle_animation()
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0:
			health_depleted.emit()


	if Input.is_action_just_pressed("gun2_switch"):
		scoreVariable.gun = 2
		
	if Input.is_action_just_pressed("gun1_switch"):
		scoreVariable.gun = 1
		
	if Input.is_action_just_pressed("gun3_switch"):
		scoreVariable.gun = 3
	
	if scoreVariable.gun == 1:
		add_child(gun1var)
		remove_child(gun2var)
		remove_child(gun3var)
		
	if scoreVariable.gun == 2:
		add_child(gun2var)
		remove_child(gun1var)
		remove_child(gun3var)
	
	if scoreVariable.gun == 3:
		add_child(gun3var)
		remove_child(gun1var)
		remove_child(gun2var)


func _on_survived_time_timeout():
	scoreVariable.survived_time += 1
	var t = scoreVariable.survived_time
	$timesurvivedlabel.text = "Time: %ss"%[str(t)]
