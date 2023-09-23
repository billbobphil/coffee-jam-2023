extends StaticBody2D

class_name Table

var isOccupied : bool = false;

func showPayoutInfo(amount : float):
	var payoutText : Label = $PayoutText;
	payoutText.text = "$" + str(amount);
	payoutText.visible = true;
	await get_tree().create_timer(2).timeout;
	payoutText.visible = false;
