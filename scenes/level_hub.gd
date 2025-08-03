extends Control

@export var ui_bullets: Array[RevolverBullet]

@onready var bullet_packs: VBoxContainer = %BulletPacks
@onready var bullet_description_label: Label = %BulletDescriptionLabel
@onready var bullet_manager: BulletManager = $BulletManager


func _ready() -> void:
	#var window = get_window()
	#window.mode = Window.MODE_FULLSCREEN
	load_barrel(UserBarrels.current_barrel)
	load_packs()

func _on_button_pressed() -> void:
	TransitionScreen.switch_to_scene(Resources.PATHS.level)

func load_barrel(barrel: BarrelInfo) -> void:
	for bullet in ui_bullets:
		if bullet.is_showing:
			bullet.animate_remove()
			await get_tree().create_timer(0.1).timeout

	await get_tree().create_timer(0.5).timeout

	var enumerator = barrel.get_enumerator()
	for bullet in ui_bullets:
		bullet.initialize(enumerator.current())
		enumerator.next()
		bullet.animate_insert()
		await get_tree().create_timer(0.1).timeout
		pass
	pass


func load_packs() -> void:
	Bullets.update_ammunition()
	var packs = Bullets.ammunition.bullet_packs
	for pack in packs:
		var pack_ui = Resources.TEMPLATES.bullet_pack_ui.instantiate()
		pack_ui.initialize(pack)
		bullet_packs.add_child(pack_ui)
		pack_ui.hovered.connect(show_bullet_description)
		pack_ui.pressed.connect(bullet_manager.add.bind(pack.bullet, pack.count))

func show_bullet_description(pack: BulletPack) -> void:
	bullet_description_label.text = pack.bullet.name + "_desc"


func _on_load_barrel(barrel_index: int) -> void:
	load_barrel(UserBarrels.barrels[barrel_index])


func _on_save_to_barrel(barrel_index: int) -> void:
	for bullet in bullet_manager.bullets:
		if not bullet:
			return
	UserBarrels.barrels[barrel_index].bullets = bullet_manager.bullets.duplicate(true)


func _on_bullet_manager_added(index: int, bullet: BulletInfo) -> void:
	var ui_bullet = ui_bullets[index]
	ui_bullet.initialize(bullet)
	ui_bullet.animate_insert()
	UserBarrels.current_barrel.bullets[index] = bullet
