extends Node2D

var state : String = "full grown"  # full grown, collectible, stump
var playerInRange : bool = false; 
var apple = preload("res://Scenes/woodCollectible.tscn")

@export var item: InventoryItem
var player = null; 
func _ready():
	pass; 
	# if state == "full grown":
		# $respawnTimer.start()
	

func _process(delta):
	# print(playerInRange);
	if state == "stump":
		$AnimatedSprite2D.play("stump")
		# $respawnTimer.start();
		
	if state == "full grown":
		$AnimatedSprite2D.play("tree");
		if playerInRange and Input.is_action_just_pressed("collect"):
			$AnimatedSprite2D.play("woodSpawn"); 
			state = "collectible"
			
	if state == "collectible":
		if playerInRange and Input.is_action_just_pressed("pickup"):
			player.collect(item); 
			state = "stump"; 
			$respawnTimer.start()


func _on_destroyable_area_body_entered(body):
	if body.has_method("player"):
		playerInRange = true; 
		player = body
	


func _on_destroyable_area_body_exited(body):
	if body.has_method("player"):
		playerInRange = false; 


func _on_respawn_timer_timeout():
	state = "full grown"; 
