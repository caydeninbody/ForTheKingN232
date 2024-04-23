extends CharacterBody2D

var speed : int = 50; 
var health : int = 100; 
var isDead : bool = false; 
var playerInArea : bool = false; 
var player; 
var attackDamage : int = 10; 
var damageArea : bool = false; 
var isAttacking : bool = false; 

func _ready():
	isDead = false;
	
func _physics_process(delta):
	
	if !isDead:
		$detectionArea/CollisionShape2D.disabled = false; 
		if isAttacking && player:
			var posFromPlayer = (player.position - self.position);
			if posFromPlayer.x > 0 && posFromPlayer.y >= -50 && posFromPlayer.y <= 50:
				$AnimatedSprite2D.scale.x = scale.y * 1;
				$AnimatedSprite2D.play("sideAttack");
			elif posFromPlayer.x < 0 && posFromPlayer.y >= -50 && posFromPlayer.y <= 50:
				$AnimatedSprite2D.play("sideAttack");
				$AnimatedSprite2D.scale.x = scale.y * -1;
			elif posFromPlayer.y < 0 && posFromPlayer.x >= -50 && posFromPlayer.x <= 50:
				$AnimatedSprite2D.play("northAttack"); 
			elif posFromPlayer.y > 0 && posFromPlayer.x >= -50 && posFromPlayer.x <= 50:
				$AnimatedSprite2D.play("southAttack");
		elif playerInArea:
			var posFromPlayer = (player.position - self.position);
			self.position += posFromPlayer/ speed; 
			print(posFromPlayer)
			if posFromPlayer.x > 0:
				$AnimatedSprite2D.scale.x = scale.y * 1;
				$AnimatedSprite2D.play("walk");
			elif posFromPlayer.x < 0:
				$AnimatedSprite2D.scale.x = scale.y * -1; 
				$AnimatedSprite2D.play("walk");
		else:
			$AnimatedSprite2D.play("idle"); 
	elif isDead:
		$detectionArea/CollisionShape2D.disabled = true; 
		


func _on_detection_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.has_method("player"):
		player = body;
		playerInArea = true; 
		


func _on_detection_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.has_method("player"):
		player = body;
		playerInArea = false; 


func _on_hit_box_area_entered(area):
	var damage : int; 
	if area.has_method("arrowDamage"):
		damage = 50; 
		takeDamage(damage); 
	

func takeDamage(damage : int):
	self.health = self.health - damage; 
	if self.health <= 0 && !isDead:
		death();
		
func death():
	isDead = true; 
	$AnimatedSprite2D.play("death"); 

	await get_tree().create_timer(1).timeout; 
	self.queue_free(); 


func _on_hit_box_body_entered(body):
	player = body;
	if player.has_method("player"):
		damageArea = true; 
		dealDamage(player); 
		
		
func _on_hit_box_body_exited(body):
	player = body;
	if player.has_method("player"):
		damageArea = false; # out of range stop attacing 

func dealDamage(enemy):
	while damageArea:
		enemy.health = enemy.health - attackDamage; 
		isAttacking = true; 
		await get_tree().create_timer(1).timeout; # 10 damage every second
		isAttacking = false; 

