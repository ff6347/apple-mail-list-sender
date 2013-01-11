(*
based on
http://veritrope.com
Apple Mail -- Text File Exporter w/ Basic Header Info.
Version 1.0
April 17, 2011
*)
set commonScript to load script alias ¬
    ((path to library folder from user domain as string) & "Scripts:Grep_Find_All.scpt")

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
        -- grep -EiEio '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b'
        set ReplyAddr to the sender of thisMessage as string
        
        set end of myList to ReplyAddr
    end repeat
    (*EXPORT TO TXT FILE *)
    set pattern to "[a-z0-9.!#$%&'+\\-/=?^_{}|~]+@[a-z0-9.]+"
    
    set theResult to myList as string
    -- set strg to theResult
    
    --set strg to do shell script "echo grep -EiEio '\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b'" & theResult 
    --set theText to strg as string
    set AppleScript's text item delimiters to _delimiters
    
    set theFileName to "Blacklist"
    set theFilePath to (SaveLoc & "_" & theFileName & ".txt")
    set theFileReference to open for access theFilePath with write permission
    write (return & theResult) to theFileReference as «class utf8» starting at eof
    close access theFileReference
    set successCount to successCount + 1
    display dialog theResult
    --set theCommand to quoted form of "perl -wne'while(/[\\w\\.]+@[\\w\\.]+/g){print \"$&\\n\"}' "
    --set posixRef to POSIX path of theFileReference
    --do shell script theCommand & posixRef
    -- display dialog theResult
end tell
