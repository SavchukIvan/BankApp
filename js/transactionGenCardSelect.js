function createOption(card){
	return "<option"+(card.balance?" ":" disabled ")+"value=\""+card.number+"\">"+card.type+" "+card.number.slice(-4)+" : "+card.balance+" ₴"+"</option>";
}

const cardSelect = document.getElementById("senderCard");

for (var i=0; i<userCards.length; i++){
	cardSelect.innerHTML += createOption(userCards[i]);
}