class_name TriggerInteractable
extends Interactable

## Doesn't have any more functionality than Interactable
## Exists to override the _on_body_entered and _on_zone_entered

func _on_body_entered(_body: Node) -> void: # No functionality
	pass

func _on_zone_entered(_area: Area2D) -> void: # No functionality
	pass
