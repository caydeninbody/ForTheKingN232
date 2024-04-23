extends CharacterBody2D

var health : int = 100;
var isDead : bool = false; 
var speed : int = 200; 
var playerState : String; 
@export var inventory : Inventory;
var playerType : String = "knight"; #Knight or Archer
var switchType : bool = false; 

var isAttacking : bool = false; 
var bowCooldown = true; 
var arrow = preload("res://Scenes/arrow.tscn")
var mouseLocationFromPlayer = null;

var knightCooldownTimer : float = 0.5; # animation timer
var archerCooldownTimer : float = 0.5; # animation timer

func _physics_process(delta):
	if health <= 0:
		death();
		await get_tree().create_timer(1).timeout;
	else:
		# print(health); 
		mouseLocationFromPlayer = get_global_mouse_position() - self.position; 
		
		if Input.is_action_just_pressed("switchType"):
			switchType = true; 
			# $AnimatedSprite2D.play("switchType")
			# await get_tree().create_timer(1).timeout;
			# switchType();
			
			
		var direction = Input.get_vector("left", "right", "up", "down"); 
		
		if direction.x == 0 && direction.y ==0:
			playerState = "idle"; 
		elif direction.x != 0 or direction.y != 0:
			playerState = "walking"
	
		velocity = direction * speed; 
		move_and_slide()
		
		var mousePosition = get_global_mouse_position();
		$Marker2D.look_at(mousePosition); 
		
		if Input.is_action_just_pressed("attack"): # && playerType == "archer" && bowCooldown:
			if playerType == "archer" && bowCooldown: # $AnimatedSprite2D.play("sideShoot");
				isAttacking = true;
				bowCooldown = false; 
				var arrowInstance = arrow.instantiate(); 
				arrowInstance.rotation = $Marker2D.rotation; 
				arrowInstance.global_position = $Marker2D.global_position; 
				add_child(arrowInstance); 
				# await get_tree().create_timer(archerCooldownTimer).timeout
				bowCooldown = true; 
			# await  get_tree().create_timer(1).timeout; 
			if playerType == "knight":
				isAttacking = true; 
				
		playAnimation(direction, isAttacking)
		
	
func playAnimation(dir, att):
	# print(isAttacking)
	if switchType == true:
		$AnimatedSprite2D.play("switchType");
		
		if playerType == "knight":
			playerType = "archer";
		else:
			playerType = "knight"; 
		await get_tree().create_timer(.45).timeout; 
		switchType = false; 
	else:	
		if playerType == "knight" && !att:
			if playerState == "idle":
				$AnimatedSprite2D.play("knightIdle"); 
			if playerState == "walking":
				if dir.x > .5: # walk east
					$AnimatedSprite2D.scale.x = scale.y * 1; #makes sure character is facing eastddddddd
					$AnimatedSprite2D.play("knightWalk");
				if dir.x < -.5: #walk west 
					$AnimatedSprite2D.scale.x = scale.y * -1; #flips character
					$AnimatedSprite2D.play("knightWalk");
				else:
					$AnimatedSprite2D.play("knightWalk")
		elif playerType == "knight" && att:
			if mouseLocationFromPlayer.x >= -25 && mouseLocationFromPlayer.y <= 25:
				$AnimatedSprite2D.play("northSlash1"); 
			if mouseLocationFromPlayer.x > 0 && mouseLocationFromPlayer.y >= -25 && mouseLocationFromPlayer.y >= 25:
				$AnimatedSprite2D.play("sideSlash1")
			if mouseLocationFromPlayer.x >= -25 && mouseLocationFromPlayer.x <= 25 && mouseLocationFromPlayer.y > 0:
				$AnimatedSprite2D.play("southSlash1")
			if mouseLocationFromPlayer.x < 0 && mouseLocationFromPlayer.y >= -25 && mouseLocationFromPlayer.y <= 25:
				$AnimatedSprite2D.scale.x = scale.y * -1;
				$AnimatedSprite2D.play("sideSlash1"); 
			await get_tree().create_timer(knightCooldownTimer).timeout;
			isAttacking = false;
		elif playerType == "archer" && !att:
			if playerState == "idle":
				$AnimatedSprite2D.play("archerIdle"); 
			if playerState == "walking":
				if dir.x > .5: # walk east
					$AnimatedSprite2D.scale.x = scale.y * 1; #makes sure character is facing eastddddddd
					$AnimatedSprite2D.play("archerWalk");
				if dir.x < -.5: #walk west 
					$AnimatedSprite2D.scale.x = scale.y * -1; #flips character
					$AnimatedSprite2D.play("archerWalk");
				else:
					$AnimatedSprite2D.play("archerWalk"); 
		elif playerType =="archer" && att:
			if mouseLocationFromPlayer.x >= -25 && mouseLocationFromPlayer.y <= 25:
				$AnimatedSprite2D.play("northShoot"); 
			if mouseLocationFromPlayer.x > 0 && mouseLocationFromPlayer.y >= -25 && mouseLocationFromPlayer.y >= 25:
				$AnimatedSprite2D.play("sideShoot")
			if mouseLocationFromPlayer.x >= -25 && mouseLocationFromPlayer.x <= 25 && mouseLocationFromPlayer.y > 0:
				$AnimatedSprite2D.play("southShoot")
			if mouseLocationFromPlayer.x < 0 && mouseLocationFromPlayer.y >= -25 && mouseLocationFromPlayer.y <= 25:
				$AnimatedSprite2D.scale.x = scale.y * -1;
				$AnimatedSprite2D.play("sideShoot"); 
			
			if mouseLocationFromPlayer.x >= 25 && mouseLocationFromPlayer.y <= -25:
				$AnimatedSprite2D.play("northSideShoot"); 
			if mouseLocationFromPlayer.x >=.5 && mouseLocationFromPlayer.y >= 25:
				$AnimatedSprite2D.play("southSideShoot")
			if mouseLocationFromPlayer.x <= -.5 && mouseLocationFromPlayer.y >= 25:
				$AnimatedSprite2D.scale.x = scale.y * -1;
				$AnimatedSprite2D.play("southSideShoot")
			if mouseLocationFromPlayer.x >=.5 && mouseLocationFromPlayer.y >= 25:
				$AnimatedSprite2D.scale.x = scale.y * -1;
				$AnimatedSprite2D.play("northSideShoot"); 
			await get_tree().create_timer(archerCooldownTimer).timeout; 
			isAttacking = false; 
		
		
func player():
	pass; 

func collect(item):
	inventory.insert(item);

func death():
	$AnimatedSprite2D.play("death")
	 
	# display game over screen
	
	
	
#unc switchType():
	# $AnimatedSprite2D.play("switchType")
	# await get_tree().create_timer(1).timeout
	#if playerType == "knight":
	#	playerType = "archer"
	#else:
	#	playerType = "knight"; 
	
