extends Node2D

@onready var playerHand = $PlayerHand
@onready var dealerHand = $DealerHand
@export var cardScene : PackedScene
@onready var handValueLabel = $"HBoxContainer/Hand value"
@onready var hitButton = $HBoxContainer/DrawButton
@onready var standButton = $HBoxContainer/StandButton

var playerCardOffset : int = 0
var dealerCardOffset : int = 0
var playerHandValue : int = 0
var deckCopy : Dictionary = {
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
	playerCardOffset = 50 * playerHand.get_child_count()
	dealerCardOffset = 50 * dealerHand.get_child_count()
	handValueLabel.text = str("Hand value: ", playerHandValue)
	
	if playerHandValue > 21:
		handValueLabel.add_theme_color_override("font_color", Color("Red"))
		hitButton.disabled = true
		standButton.disabled = true
	elif playerHandValue == 21:
		handValueLabel.add_theme_color_override("font_color", Color("Green"))
	else:
		handValueLabel.add_theme_color_override("font_color", Color("White"))

func _on_draw_card_button_pressed():
	var cardInstance = drawRandomCard()
	cardInstance.position = Vector2(playerCardOffset, 0)
	playerHand.add_child(cardInstance)
	playerHandValue += cardInstance.cardValue

func _on_reset_button_pressed():
	for card in playerHand.get_children():
		card.queue_free()
	playerHandValue = 0
	#The duplicate function doesn't work, so, I have to reassign the dictionary from scratch if I want to reset the deck.
	deckCopy = {
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
	hitButton.disabled = false
	standButton.disabled = false
	

func _on_stand_button_pressed():
	pass # Replace with function body.

#Draws a random card and remove it from the deck. Returns a sprite2D with the card's info
func drawRandomCard():
	var drawnSuit = randi_range(0, deckCopy.size() - 1)
	var drawnSuitRandom = deckCopy.keys()[drawnSuit]
	var randomCard = randi_range(0, deckCopy[drawnSuitRandom]["names"].size() - 1)
	var randomCardName = deckCopy[drawnSuitRandom]["names"][randomCard]
	var randomCardValue = deckCopy[drawnSuitRandom]["values"][randomCard]
	var cardInstance = cardScene.instantiate()
	cardInstance.cardSuit = drawnSuitRandom
	cardInstance.cardName = randomCardName
	cardInstance.cardValue = randomCardValue
	deckCopy[drawnSuitRandom]["names"].remove_at(randomCard)
	deckCopy[drawnSuitRandom]["values"].remove_at(randomCard)
	if deckCopy[drawnSuitRandom]["names"].size() == 0:
		deckCopy.erase(drawnSuitRandom)
	return cardInstance
