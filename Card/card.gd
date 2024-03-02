extends Sprite2D

var cardSuit : String
var cardName : String
var cardValue : int
var cardsPath = "res://Assets/Cards/"

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = load(str(cardsPath, cardSuit, "_", cardName, ".png"))
