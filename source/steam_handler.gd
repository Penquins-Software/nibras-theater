extends Node


const STEAM_APP_ID: int = 3411140


func _init():
	#initialize_steam()
	pass


func initialize_steam() -> void:
	var _initialize_response: Dictionary = Steam.steamInitEx(true, STEAM_APP_ID)
	#print("Did Steam initialize?: %s " % initialize_response)


func unlock_achievement(value: String) -> void:
	Steam.setAchievement(value)
	Steam.storeStats()
