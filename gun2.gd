extends Area2D


func _physics_process(delta):
	var enemies_in_range2 = get_overlapping_bodies()
	if enemies_in_range2.size() > 0:
		var target_enemy2 = enemies_in_range2.front()
		look_at(target_enemy2.global_position)
		
func shoot():
	var new_bullet2 = preload("res://bullet.tscn").instantiate()
	new_bullet2.global_position = $%ShootingPoint2.global_position
	new_bullet2.global_rotation = %ShootingPoint2.global_rotation
	%ShootingPoint2.add_child(new_bullet2)


func _on_timer_timeout():
	shoot()
