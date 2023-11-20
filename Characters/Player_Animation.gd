extends Node2D

@onready var animation : AnimatedSprite2D = $Animation
#var slash_fx : GPUParticles2D = null
var has_played : bool = false

func update_animation(direction : Vector2, is_action : bool, player_index : int, state : Dictionary ) -> void:
	if direction.x == 1:
		animation.flip_h = false
		if not is_action and player_index == 0:
#			slash_fx = $"../FX/slash FX R"
			var slash = $Slash
			slash.flip_h = false
			slash.position.x = 24
	else:
		animation.flip_h = true
		if not is_action and player_index == 0:
#			slash_fx = $"../FX/slash FX L"
			var slash = $Slash
			slash.flip_h = true
			slash.position.x = -24
			
	if is_action:
		if player_index == 0 and not has_played:
			play_slash_animation(direction)
		else:
			pass
	else:
#		print(state)
		if state["jump"]:
			animation.play("jump up")
		elif state["fall"]:
			if player_index == 0:
				animation.play("jump limit")
				while get_parent().velocity.y < 0:
					animation.play("jump fall")
					break
			else:
				animation.play("jump fall")
				if animation.frame == 1:
					animation.pause()
		elif state["run"]:
			animation.play("run")
		else:
			animation.play("idle")
#		if state == p:
#			anim.play("jump up")
#		elif velocity.y > 0:
#			if controls.player_index == 0:
#				anim.play("jump limit")
#				while velocity.y < 0:
#					anim.play("jump fall")
#					break
#			else:
#				anim.play("jump fall")
#		elif Input.is_action_pressed(controls.right) or Input.is_action_pressed(controls.left):
#			anim.play("run")
#		else:
#			anim.play("idle")

func play_slash_animation(direction) -> void:
	if direction.y == 1:
		animation.play("attack down")
		var slash = $"Down Slash"
		slash.visible = true
		slash.play("down slash")
		has_played = true
#				if slash.frame == 4:
#					slash.visible = false
	else:
		animation.play("attack front")
#				var slash_fx_timer = $"SlashFX timer"w
#				slash_fx.emitting = true
#				slash_fx_timer.start()
		var slash = $Slash
		slash.visible = true
		slash.play("slash")
		has_played = true
#				if slash.frame == 3:
#					slash.visible = false
#					print("hi")

func _on_slash_animation_finished() -> void:
	has_played = false

func _on_down_slash_animation_finished() -> void:
	has_played = false
