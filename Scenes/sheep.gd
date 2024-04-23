extends CharacterBody2D

var speed : int = 900; 
var health : int = 10; 
var isDead : bool = false; 
var targetLocation : Vector2; 
var state : String; 
var walkingTimer : int = 0; 

func _ready():
	isDead = false;
	getNewLocation();
	state = "idle"; 
	
func _physics_process(delta):
	if !isDead:
		if state == "walking":# move towards new position
			self.position += (targetLocation - self.position) / speed
			$AnimatedSprite2D.play("walk")
			if self.position == targetLocation || walkingTimer > 500:
				state = "idle";
				getNewLocation()
			else:
				walkingTimer += 1; 
		elif state == "idle":
			walkingTimer = 0;
			$AnimatedSprite2D.play("idle"); 
			await get_tree().create_timer(3).timeout
			state = "walking";


func getNewLocation():
	targetLocation.x = randi_range(-1828, 1378)
	targetLocation.y = randi_range(60, 2917)
	# print("New location " +str(targetLocation))
	# print("self pos " + str(self.position)); 


func _on_hit_box_area_entered(area):
	var damage : int;
	if area.has_method("arrowDamage"):
		damage = 50;
		takeDamage(damage);
		
func takeDamage(dmg):
	self.health -= dmg;
	if self.health <= 0 && !isDead:
		death();
		
func death():
	isDead = true; 
	$AnimatedSprite2D.play("death"); 

	await get_tree().create_timer(1).timeout; 
	self.queue_free(); 
