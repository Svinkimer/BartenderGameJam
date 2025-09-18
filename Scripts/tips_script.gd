class_name Tips
extends InteractiveObject

var reward: int = 0
var idx: int = -1
func setup_reward(reward_val: int):
	reward = reward_val
	
func add_reward(additional_reward: int):
	reward += additional_reward

func on_click():
	CoinRattle.play()
	GameState.collect_tips(idx)
