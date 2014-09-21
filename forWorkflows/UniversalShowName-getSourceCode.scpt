tell application "Safari"
	set sourceCode to source of current tab of window index 1 of application "Safari"
end tell
return sourceCode