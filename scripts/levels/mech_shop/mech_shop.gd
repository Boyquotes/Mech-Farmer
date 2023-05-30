extends Node3D

@export var varmint_cannon_scene: PackedScene
@export var heavy_flamer_scene: PackedScene

@onready var player = get_node("Player")
@onready var primary_slot_1 = player.get_node("Torso/Guns/PrimarySlot1")
@onready var primary_slot_2 = player.get_node("Torso/Guns/PrimarySlot2")

func _on_varmint_cannon_button_pressed():
	var varmint_cannon_1 = varmint_cannon_scene.instantiate()
	var varmint_cannon_2 = varmint_cannon_scene.instantiate()
	primary_slot_1.get_child(0).queue_free()
	primary_slot_1.add_child(varmint_cannon_1)
	primary_slot_2.get_child(0).queue_free()
	primary_slot_2.add_child(varmint_cannon_2)

func _on_heavy_flamer_button_pressed():
	var heavy_flamer_1 = heavy_flamer_scene.instantiate()
	var heavy_flamer_2 = heavy_flamer_scene.instantiate()
	primary_slot_1.get_child(0).queue_free()
	primary_slot_1.add_child(heavy_flamer_1)
	primary_slot_2.get_child(0).queue_free()
	primary_slot_2.add_child(heavy_flamer_2)
