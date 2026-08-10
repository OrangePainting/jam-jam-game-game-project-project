class_name TriggerInteractable
extends Interactable

## Doesn't have any more functionality than Interactable
## Exists to override the _on_body_entered and _on_zone_entered

@export var interact_sound: String = ""

# Generic interact function that happens when can_pick_up is false
func interact(interactor: Node2D) -> bool:
	if not can_interact: return false
	
	interacted_with.emit(interactor)
	if AudioController.has_method(interact_sound):
		AudioController.call(interact_sound)
	
	return true

func _on_body_entered(_body: Node) -> void: # No functionality
	super._on_body_entered(_body) # MUST ADD THIS AT EVERY ON BODY ENTERED FUNCTION

func _on_zone_entered(_area: Area2D) -> void: # No functionality
	pass
