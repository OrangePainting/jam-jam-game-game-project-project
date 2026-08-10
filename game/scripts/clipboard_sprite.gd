extends Control

@onready var sprite = %ClipboardSprite
@onready var bullet_text = %Bullets
var things_completed: int = 0


var clipboard_bullets: Array[String] = [
	"Acorn",
	"Peanut",
	"Coconut",
	"Lockbox",
	"Vault",
	"Acorn Statue"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet_text.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var t = ""
	for i in range(len(clipboard_bullets)):
		if i < things_completed:
			t += "[s color = 'green']" + clipboard_bullets[i] + "[/s]" + "\n"
		else:
			t += clipboard_bullets[i] + "\n"
	bullet_text.text = "[ul]" + t + "[/ul]"
