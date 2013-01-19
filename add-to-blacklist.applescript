(*
based on
http://veritrope.com
Apple Mail -- Text File Exporter w/ Basic Header Info.
Version 1.0
April 17, 2011
*)

property appName : "Mail"
property successCount : "0"


(*TEMP FILES PROCESSED ON THE DESKTOP*)
tell application "Finder"
	if (the folder "Blacklist" exists) then set FolderLoc to (the folder "Blacklist")
	if not (the folder "Blacklist" exists) then
		set FolderLoc to (make new folder at (path to desktop folder) with properties {name:"Blacklist"})
	end if
	set SaveLoc to FolderLoc as string
end tell

(*APPLE MAIL ITEM SELECTION *)
tell application "Mail"
	set theMessages to selection
	
	(*CLEAN TITLE FOR FILE *)
	set _delimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to return
	set myList to {}
	
	repeat with thisMessage in theMessages
		set ReplyAddr to the sender of thisMessage as string
		set end of myList to ReplyAddr
	end repeat
	
	set theResult to myList as string

	set AppleScript's text item delimiters to _delimiters
	
	
	set theFileName to "Blacklist"
	set theFilePath to (SaveLoc & theFileName & ".txt")
	set p_path to POSIX path of theFilePath
	set theFileReference to open for access theFilePath with write permission
	write (return & theResult) to theFileReference as Çclass utf8È starting at eof
	close access theFileReference
	set successCount to successCount + 1

	set resultstring to do shell script "grep -EiEio '\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b' " & p_path
	do shell script "echo " & resultstring & " > " & p_path
end tell
