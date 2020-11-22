var senderCardData;

const card1 = {
	number : "4000 0003 1711 5805",
	type   : "debit",
	balance: 0.01
}

const card2 = {
	number : "4000 0007 6809 6004",
	type   : "debit",
	balance: 0.0
}

const card3 = {
	number : "4000 0023 3977 9678",
	type   : "debit",
	balance: 1000.00
}

const card4 = {
	number : "4000 0063 1244 0232",
	type   : "credit",
	balance: 0.0
}

const userCards = [card1, card2, card3, card4];


function getCardByNumber(number){
	for (var i=0; i<userCards.length; i++){
		if (userCards[i].number === number) return userCards[i];
	}
}