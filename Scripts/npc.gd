extends CharacterBody2D

var player ;
var playerInQuestZone : bool = false; 

func _ready():
	$AnimatedSprite2D.play("idle"); 

func _physics_process(delta):
	if playerInQuestZone:
		$NPCChatBox.visible = true; 
	else:
		$NPCChatBox.visible = false; 
		
func setPlayerInQuestZone(inQuestZone : bool):
	self.playerInQuestZone = inQuestZone; 
	
	
	
func _on_quest_box_area_body_entered(body):
	if body.has_method("player"):
		player = body
		setPlayerInQuestZone(true); 
	
	


func _on_quest_box_area_body_exited(body):
	if body.has_method("player"):
		player = body
		setPlayerInQuestZone(false); 


func _on_player_meat_picked_up():
	$NPCChatBox.meatPickedUp(); 


func _on_player_wood_picked_up():
	$NPCChatBox.woodPickedUp(); 
	print("wood picked up")
