extends Node2D


func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()
	

func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	var t = scoreVariable.survived_time
	$GameOver/ColorRect/Label.text = "Game Over\nTime Survived: %s seconds"%[t]
	get_tree().paused = true
