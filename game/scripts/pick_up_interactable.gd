extends Interactable

## Doesn't have any more functionality than Interactable
## Exists to override the _on_body_entered and _on_zone_entered

@export var break_on_use: bool = false

func _on_body_entered(_body: Node) -> void: # No functionality
	super._on_body_entered(_body) # MUST ADD THIS AT EVERY ON BODY ENTERED FUNCTION

func _on_zone_entered(_area: Area2D) -> void: # No functionality
	pass

func _on_nut_broken_open() -> void:
	if break_on_use:
		queue_free()
