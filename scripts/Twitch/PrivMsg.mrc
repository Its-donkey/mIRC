; raw PRIVMSG:*:{
;     echo -a @Main_Chat PRIVMSG rawmsg: $rawmsg
;     echo 1 @debuger 1- $1-
; }

; raw USERNOTICE:*:{
;     echo 4 -a usernotice rawmsg: $rawmsg
; }

; raw *:*:{
;   echo -m @Main_Chat $rawmsg
; }

; on *:PARSELINE:*:*:{

; var %uidd = $msgtags(user-id=).key

;  echo -m @Main PARSETYPE $parsetype : PARSEUTF $parseutf : $parseline
 
;  ; $gettok($parseline,15, 59) : Alternate $msgtags(user-id) -- %uidd
 
;   var %i = 1
;   while ($msgtags(%i)) {
;     var %tag = $msgtags(%i)
;     var %value = $msgtags(%tag)
;     echo -m @MsgTags $timestamp Tag: %tag, Value: %value
;     inc %i
;   }
; }

raw USERSTATE:*:{
;    window -H $1- $+ _Chat
    echo 1 @debug USERSTATE RAWMSG: $rawmsg 
    echo 1 @debug 1- $1-
}

raw ROOMSTATE:*:{
;    window -H $1- $+ _Chat
    echo 1 @debug ROOMSTATE This is the RAWMSG: $rawmsg 
    echo 1 @debug 1- $1-
}

    /* do stuff with $regml(1) */

    ; have mIRC handle the rest of the message
    parse $regml(2)
    halt

  

;  if ($parsetype == in) {
;    var %pl = $parseline
 
;    ; UTF decode the line ourselves
;    if ($parseutf) %pl = $utfdecode(%pl)
 
;    ; Convert the line to upper case
;    %pl = $upper(%pl)
 
;    ; Replace the current incoming line with our line
;    ; We use -u0 to prevent mIRC from UTF decoding the line as we have already done that
;    parseline -itu0 %pl
 
;    ; The line will only be processed after our script returns
;    return
;  

 
 ; The original incoming/outgoing line will be processed as normal
; 