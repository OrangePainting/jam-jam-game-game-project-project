extends PlaceInteractable

signal end_game

# Overrides the default one because we need this one to do something different.
func interact_with_held(interactor: Node2D, held_item: Interactable) -> bool:
	if not can_interact:
		if AudioController.has_method(decline_sound):
			AudioController.call(decline_sound)
		return false	
	
	if not opened:
		if held_item.name.match(key_item_name):
			opened = true
			item_placed.emit(interactor, held_item)
			AudioController.play_demolition_crane_sound()
			
			end_game.emit()
			
			if delete_on_key_used:
				held_item.queue_free()
			
			return true
		else:
			if AudioController.has_method(decline_sound):
				AudioController.call(decline_sound)
	return false
