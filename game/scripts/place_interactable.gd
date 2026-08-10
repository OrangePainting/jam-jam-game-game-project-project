class_name PlaceInteractable
extends Interactable

## Interactable that requires the bird to be holding a specific item
## When interacted with after putting the item in, will emit a signal

@export var key_item_name: String = "" # When interacted with this item do something

@export var accept_sound: String = ""
@export var decline_sound: String = ""
@export var interact_sound: String = ""

@export var delete_on_key_used: bool = false

var opened: bool = false

signal item_placed(interactor: Node2D, item: Interactable)

func _ready() -> void:
	if key_item_name == "":
		push_error("%s's key_item_name is empty" % name)
	
	super()


func interact(interactor: Node2D) -> bool:
	if not can_interact or not opened: return false
	
	# Code for interacting with interactable after giving the correct item
	if AudioController.has_method(interact_sound):
		AudioController.call(interact_sound)
	interacted_with.emit(interactor)
	
	return true

func interact_with_held(interactor: Node2D, held_item: Interactable) -> bool:
	if not can_interact:
		if AudioController.has_method(decline_sound):
			AudioController.call(decline_sound)
		return false	
	
	if not opened:
		if held_item.name.match(key_item_name):
			opened = true
			item_placed.emit(interactor, held_item)
			if AudioController.has_method(accept_sound):
				AudioController.call(accept_sound)
			if delete_on_key_used:
				held_item.queue_free()
			
			leave_after_delay()
			
			return true
		else:
			if AudioController.has_method(decline_sound):
				AudioController.call(decline_sound)
	return false

func _on_body_entered(_body: Node) -> void: # No functionality
	super._on_body_entered(_body) # MUST ADD THIS AT EVERY ON BODY ENTERED FUNCTION

func _on_zone_entered(_area: Area2D) -> void: # No functionality
	pass


func leave_after_delay() -> void:
	await get_tree().create_timer(3.0).timeout
	$AnimatedSprite2D.frame = 1
