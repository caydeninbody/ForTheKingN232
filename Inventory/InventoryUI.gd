extends Control

@onready var inventory : Inventory = preload("res://Inventory/PlayerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children(); 

var isOpen : bool = false; 

func _ready():
	inventory.update.connect(updateSlots); 
	updateSlots(); 
	closeInventory();
	
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if isOpen:
			closeInventory(); 
		else:
			openInventory(); 
			
func openInventory():
	visible = true; 
	isOpen = true; 
	
	
func closeInventory():
	visible = false; 
	isOpen = false; 

func updateSlots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
