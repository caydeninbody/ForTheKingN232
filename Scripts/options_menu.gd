extends Control
@export var mainMenu : PackedScene; 
# on back pressed load packed scene of menu


func _on_back_pressed():
	print("back")
	get_tree().change_scene_to_packed(mainMenu); 
