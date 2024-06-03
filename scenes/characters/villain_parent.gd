extends actor
class_name villain

func _init():
	signal_setup()
	VILLAIN_INFO.intention_set()

func _process(_delta):
	debug_commands()

func effect_villian():
	if (VILLAIN_INFO.hp <= 0):
		_villain_defeated()

func villain_turn():
	VILLAIN_INFO.block = 0
	await get_tree().create_timer(0.2).timeout
	
	SignalBus.power.emit()
	squish_squash()
	#TODO MAKE THIS NOT A TIMER YUCKITY YUCKITY YUCK DRUCKS MCDUCKS. Could we just await squish_squash?
	await get_tree().create_timer(0.5).timeout
	VILLAIN_INFO.intention_set()
	SignalBus.villain_turn_end.emit()
	#_villain_turn_end()

func villain_turn_end():
	SignalBus.villain_turn_end.emit()

func interfere():
	SignalBus.spawn_bouncy.emit()

func _villain_defeated():
	SignalBus.villain_defeated.emit()

func signal_setup():
	SignalBus.power_end.connect(effect_villian)
	SignalBus.turn_end.connect(villain_turn)

func debug_commands():
	if Input.is_action_just_pressed("debug_villain_health_down"):
		VILLAIN_INFO.hp = 1
