extends Node2D

@onready var cardDrawnLabel = $CardDrawn
var cardsDeck : Dictionary = {
	"hearts":
		{
			"names": ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"],
			"values": [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]
			},
	"clubs":
		{
			"names": ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"],
			"values": [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]
			},
	"spades":
		{
			"names": ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"],
			"values": [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]
			},
	"diamonds":
		{
			"names": ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"],
			"values": [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]
			}
		,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_draw_card_button_pressed():
	var drawnSuit = randi_range(0, cardsDeck.size() - 1)
	var drawnSuitRandom = cardsDeck.keys()[drawnSuit]
	var randomCard = randi_range(0, cardsDeck[drawnSuitRandom]["names"].size() - 1)
	var randomCardName = cardsDeck[drawnSuitRandom]["names"][randomCard]
	var randomCardValue = cardsDeck[drawnSuitRandom]["values"][randomCard]
	cardDrawnLabel.text = str("You've drawn the ", randomCardName, " of ", drawnSuitRandom, ". Which has a value of ", randomCardValue, "." )
