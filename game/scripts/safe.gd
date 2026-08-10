extends BreakableInteractable

# Enable the zone detection when it breaks

func _break_open():
	super()
	zone_detector.get_child(0).disabled = false;
