class_name PlaceInteractable
extends Interactable

## Interactable that requires the bird to be holding a specific item

@export var key_item_name: String = ""

var opened: bool = false

signal item_placed(interactor: Node2D, item: Interactable)

func _ready() -> void:
	if key_item_name == "":
		push_error("%s's key_item_name is empty" % name)
	
	super()

func interact(interactor: Node2D) -> bool:
	if not super(interactor): return false
	
	# Do something maybe
	
	return true

func interact_with_held(interactor: Node2D, held_item: Interactable) -> bool:
	if not can_interact:
		AudioController.play_man_decline_nut_sound() # idk if this will break other parts of the game
		return false
	print(held_item.name)
	
	if not opened:
		if held_item.name.match(key_item_name):
			opened = true
			item_placed.emit(interactor, held_item)
			AudioController.play_man_accept_nut_sound() # idk if this will break other parts of the game
			return true
		else:
			AudioController.play_man_decline_nut_sound() # idk if this will break other parts of the game
	
	return false

func _on_body_entered(_body: Node) -> void: # No functionality
	super._on_body_entered(_body) # MUST ADD THIS AT EVERY ON BODY ENTERED FUNCTION

func _on_zone_entered(_area: Area2D) -> void: # No functionality
	pass
