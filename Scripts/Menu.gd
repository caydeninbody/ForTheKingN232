extends Control

@export var worldMap : PackedScene; 
@export var optionsMenu : PackedScene; 


func _on_start_button_pressed():
	get_tree().change_scene_to_packed(worldMap)


func _on_options_button_pressed():
	get_tree().change_scene_to_packed(optionsMenu)


func _on_quit_button_pressed():
	get_tree().quit()
