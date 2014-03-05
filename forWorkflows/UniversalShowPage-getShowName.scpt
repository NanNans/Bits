on run {input}
	
	tell application "System Events"
		set showName to name of window index 1 of application "Safari"
	end tell
	return {input, showName} as text
	
end run