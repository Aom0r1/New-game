extends ProgressBar

@onready var character = $"../../.."
@onready var text = $"../Label"

func _ready():
	max_value = character.hp

func _process(delta):
	value = character.hp
	text.text = str(value) + "/" + str(max_value)
