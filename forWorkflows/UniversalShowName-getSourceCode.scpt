tell application "Safari"
	set sourceCode to source of tab 1 of window index 1 of application "Safari"
end tell
return sourceCode