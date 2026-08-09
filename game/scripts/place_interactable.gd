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
	if not can_interact: return false
	print(held_item.name)
	
	if not opened and held_item.name.match(key_item_name):
		opened = true
		item_placed.emit(interactor, held_item)
		return true
	
	return false

func _on_body_entered(_body: Node) -> void: # No functionality
	pass

func _on_zone_entered(_area: Area2D) -> void: # No functionality
	pass
