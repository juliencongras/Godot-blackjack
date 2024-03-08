extends Node2D

@onready var playerHand = $PlayerHand
@onready var dealerHand = $DealerHand
@export var cardScene : PackedScene
@onready var handValueLabel = $"HBoxContainer/Hand value"
@onready var dealerHandValueLabel = $"HBoxContainer2/Dealer's hand value"
@onready var hitButton = $HBoxContainer/DrawButton
@onready var standButton = $HBoxContainer/StandButton
@onready var dealerDrawCooldown = $"Dealer draw cooldown"

var playerCardOffset : int = 0
var dealerCardOffset : int = 0
var playerHandValue : int = 0
var dealerHandValue : int = 0
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
	blackjackGameStart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerHandValue = totalPlayerHandValue()
	dealerHandValue = totalDealerHandValue()
	handValueLabel.text = str("Hand value: ", playerHandValue)
	dealerHandValueLabel.text = str("Dealer's hand value: ", dealerHandValue)
	
	if playerHandValue > 21:
		for card in playerHand.get_children():
			if card.cardValue == 11:
				card.cardValue = 1
				break
		hitButton.disabled = true
		standButton.disabled = true

func _on_draw_card_button_pressed():
	addPlayerCard()

func _on_reset_button_pressed():
	blackjackGameStart()

func _on_stand_button_pressed():
	while dealerHandValue < 17:
		addDealerCard()
	
	#Player wins
	if dealerHandValue < playerHandValue or dealerHandValue > 21:
		print("Player wins!")
	#Dealer wins
	elif dealerHandValue > playerHandValue:
		print("Dealer wins!")
	#Draw
	else:
		print("Draw!")

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

#Add a random card from the deck to the player's hand.
func addPlayerCard():
	var cardInstance = drawRandomCard()
	cardInstance.position = Vector2(playerCardOffset, 0)
	playerHand.add_child(cardInstance)
	playerCardOffset += 50

#Add a random card from the deck to the dealer's hand.
func addDealerCard():
	var cardInstance = drawRandomCard()
	cardInstance.position = Vector2(dealerCardOffset, 0)
	dealerHand.add_child(cardInstance)
	dealerCardOffset += 50

func totalPlayerHandValue():
	var totalValue : int = 0
	for card in playerHand.get_children():
		totalValue += card.cardValue
	return totalValue

func totalDealerHandValue():
	var totalValue : int = 0
	for card in dealerHand.get_children():
		totalValue += card.cardValue
	return totalValue

#Use this function when starting a new blackjack game.
func blackjackGameStart():
	for card in playerHand.get_children():
		card.queue_free()
	for card in dealerHand.get_children():
		card.queue_free()
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
	playerCardOffset = 0
	dealerCardOffset = 0
	addDealerCard()
	addPlayerCard()
	addPlayerCard()
