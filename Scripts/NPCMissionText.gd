extends Control

@export var winMenu : PackedScene; 

var missionComplete : bool = false; 
var meatCollected : int = 0; 
var woodCollected : int = 0; 

func _physics_process(delta):
	if missionComplete:
		$currentMission.visible = false; 
		$missionComplete.visible = true; 
	else:
		$currentMission.visible = true; 
		$missionComplete.visible = false; 
		
	checkMissionCompleted(8 , 15) # sheep meat, wood
	
	
	
func checkMissionCompleted(meatRequired : int, woodRequired : int):
	if meatCollected >= meatRequired && woodCollected >= woodRequired:
		missionComplete = true; 
		print("mission compelte")
		# switch to you win menu
	else:
		missionComplete = false; 
		print(str(meatCollected) + "/" + str(meatRequired) + "\n"+ str(woodCollected) + "/" + str(woodRequired))
		
func meatPickedUp():
	meatCollected += 1; 
	print("meat collected = " )
	
func woodPickedUp():
	woodCollected += 1; 


func _on_button_pressed():
	get_tree().change_scene_to_packed(winMenu); 
