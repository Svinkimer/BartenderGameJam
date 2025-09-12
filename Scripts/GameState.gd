extends Node


#region MANAGEMENT OF INGREDIENTS
const MAX_DRINKS_IN_MIX: int = 3

var drinks_in_mixer: Array[StringName] = []

func add_drink_in_mixer(key: StringName) -> bool:
	# mixer cup is full
	if len(drinks_in_mixer) >= MAX_DRINKS_IN_MIX:
		print("Mixer is full")
		return false;
		
	for drink in drinks_in_mixer:
		# same drink -> nothing happens
		if key == drink:
			print("This drink was already poured in shake")
			return true;
	
	drinks_in_mixer.push_front(key);
	
	print(drinks_in_mixer)
	
	return true


#endregion



func generate_client():
	pass
