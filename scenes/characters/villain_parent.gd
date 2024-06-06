extends actor
class_name villain

func _init():
	signal_setup()
	Global.VILLAIN_INFO.intention_set()

func _process(_delta):
	debug_commands()

func effect_villian():
	if (Global.VILLAIN_INFO.hp <= 0):
		_villain_defeated()

func villain_turn():
	Global.VILLAIN_INFO.block = 0
	await get_tree().create_timer(0.2).timeout
	print(Global.VILLAIN_INFO.value)
	match Global.VILLAIN_INFO.intention:
		"attack":
			SignalBus.player_damage.emit(Global.VILLAIN_INFO.value + Global.VILLAIN_INFO.strength)
			SignalBus.villain_attack.emit(Global.VILLAIN_INFO.intention)
			SignalBus.screen_vfx.emit("attack_villain")
			animation_player.play("attack_slide")
		"block":
			SignalBus.screen_vfx.emit("block_villain")
			Global.VILLAIN_INFO.block += Global.VILLAIN_INFO.value
		"interfere":
			SignalBus.spawn_bouncy.emit()
		"debuff":
			Global.VILLAIN_INFO.sap += Global.VILLAIN_INFO.value
		"buff":
			Global.VILLAIN_INFO.strength += Global.VILLAIN_INFO.value
	squish_squash()
	#TODO MAKE THIS NOT A TIMER YUCKITY YUCKITY YUCK DRUCKS MCDUCKS. Could we just await squish_squash?
	await get_tree().create_timer(0.5).timeout
	Global.VILLAIN_INFO.intention_set()
	print(Global.VILLAIN_INFO.intention)
	SignalBus.villain_turn_end.emit()

func interfere():
	SignalBus.spawn_bouncy.emit()

func _villain_defeated():
	SignalBus.villain_defeated.emit()

func signal_setup():
	SignalBus.power_end.connect(effect_villian)
	SignalBus.turn_end.connect(villain_turn)
	SignalBus.villain_damage.connect(Global.VILLAIN_INFO.take_damage)


func debug_commands():
	if Input.is_action_just_pressed("debug_villain_health_down"):
		Global.VILLAIN_INFO.hp = 1
