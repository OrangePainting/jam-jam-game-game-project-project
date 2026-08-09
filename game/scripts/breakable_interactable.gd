class_name BreakableInteractable
extends Interactable

## Can be picked up and breaks on contact with objects named break_on_name
## 
## Can be picked up and dropped inherited from Interactable 
## Breaks on contact with objects named break_on_name

@export var break_on_name: String = ""

var broken: bool = false;

func _on_body_entered(body: Node) -> void:
	# If the body is named break_on_name
	if (not broken and not is_held and not break_on_name.is_empty() 
	and body.name.match(break_on_name)):
		_break_open()

func _on_zone_entered(_area: Area2D) -> void: # No functionality
	pass

# Controls the breaking open animation
func _break_open():
	print("%s broke!" % name)
	broken = true
	set_deferred("freeze", true)
	set_deferred("position", position)
	$AnimatedSprite2D.play("Cracked")
	
