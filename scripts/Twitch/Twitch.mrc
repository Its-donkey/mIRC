alias checkAndConnect {
  var %tusername = $readini(credentials.ini, n, Twitch, Username)
  if (%tusername == $null) {
    %tusername = $input(Enter your Twitch username,e,,"Twitch Username",)
    writeini credentials.ini Twitch Username %tusername
  }

  var %toauth = $readini(credentials.ini, n, Twitch, OAuth)
  
  ; Check if the username was found in the file
  if (%toauth == $null) {
        ; OAuth not found, handle accordingly, maybe display an error message
      %toauth = $input(Enter your Twitch OAuth Tolen,p,,,)
      writeini credentials.ini Twitch OAuth %toauth
  }

  if ((%tusername != $null) && (%toauth != $null)) {
    server irc.chat.twitch.tv 6667 %oauthToken -i %twitchUsername
  }
}

; You might want to call this alias from an on start event or manually.
; To connect automatically when mIRC starts, use the on START event:
on *:START:{
  checkAndConnect
}


on *:CONNECT:{
  if ($server == tmi.twitch.tv) {

    ; Request IRCv3 tags for metadata
    CAP REQ :twitch.tv/tags
    ; Request Twitch-specific commands
    CAP REQ :twitch.tv/commands
    ; Request membership state event capabilities
    CAP REQ :twitch.tv/membership
    ; After sending the CAP REQ commands, you can join channels
    ; Join your channel of interest, replace "yourchannel" with the actual channel name
    JOIN $chr(35) $+ $readini(credentials.ini, n, Twitch, Username)
  }
}

on *:TEXT:*:#:{
  ;   var %tags = $regsubex($rawmsg,/^@([^ ]+) .+$/, \1)
  ;   ; var %userid = $gettok($gettok(%tags, $calc($numtok(%tags, ;) - $numtok(%tags, ;, user-id=) + 1), ;, =), 2, ;)
  ;   var %userid = $gettok($gettok(%tags, $findtok(%tags, user-id, 1, ;), 32), 2, =)
  ;   ; var %uuid = $msgtags(user-id).key

  ;   var %uuid = unknown ; Initialize with a default value

  ;   ; Attempt to extract user-id using regex
  ;   if ($regex(%tags, /user-id=(\d+)/)) {
  ;     %uuid = $regml(1)
  ;}
  ; var %tag_key = $msgtags(user-id).key
  ;   var %SN = 1
  ;   while ($msgtags(%SN).tag) { 
  ;     echo 6 @debug . %SN $msgtags(%SN).tag $msgtags($msgtags(%SN).tag).key
  ;     inc %SN
  ;}

  ; var %uuidd =  echo 3 $msgtags($msgtags(%SN).tag).key and $msgtags(16).value

  ;   echo -s $chan $+ : $nick (UserID: %tag_key ) $+ : $1-

  var %tag_key = $msgtags(user-id).key
  var %tag_value = $msgtags(display-name).key

  ; Displaying the key and value
  echo -s Key: %tag_key Value: %tag_value
  ; write 'userid.txt' $chan $+ : $nick (UserID: %userid) $+ : $1-

  ;showtags $chan

}

 