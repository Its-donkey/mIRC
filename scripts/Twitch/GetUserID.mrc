; Define a command to retrieve the broadcaster ID
alias getBroadcasterID {
  ; Define your Twitch channel name
  var %channel = $readini(credentials.ini, n, Twitch, Username)

  ; Open a connection to the Twitch API server
  sockopen TwitchAPI api.twitch.tv 443

  ; Send a request to the Twitch API
  sockmark TwitchAPI GET /helix/users?login=%channel HTTP/1.1
  sockmark TwitchAPI Host: api.twitch.tv
  sockmark TwitchAPI Connection: close
  sockmark TwitchAPI User-Agent: mIRC
  sockmark TwitchAPI 

  ; Display a message indicating that the request is being sent
  echo -a Sending request to retrieve broadcaster ID for %channel...
}

; Handle incoming data from the Twitch API server
on *:sockread:TwitchAPI:{
  ; Read a line of data from the socket
  var %data
  sockread %data

  ; Parse the response from the Twitch API
  if (%data == $null) {
    ; No more data available, close the connection
    sockclose TwitchAPI
  }
  else {
    ; Parse the JSON response to extract the broadcaster ID
    ; (You'll need to implement JSON parsing logic here)
    ; For simplicity, let's assume the broadcaster ID is in the "id" field

    ; Extract the broadcaster ID from the response
    var %broadcasterID = $getfield(%data, id)

    ; Display the broadcaster ID in the mIRC client window
    echo -a Broadcaster ID for %channel: %broadcasterID
  }
}

alias getUserID {
 
  ; Define your channel name and Twitch API endpoint
  var %channel = $input(Enter username,e,,"Username","default text")
  var %twitchAPI = 

  ; Use cURL to make the HTTP GET request and capture the response
  ; run cmd /c curl -H "Client-Id: rmteckwmdsph1svyhcn70pmni3k1lb" -H "Authorization: Bearer YOUR_ACCESS_TOKEN_HERE" https://api.twitch.tv/helix/users?login= $+ %channel > user_id.txt
  
  lnbreak
  var %url = -H "Client-Id: rmteckwmdsph1svyhcn70pmni3k1lb" -H "Authorization: Bearer YOUR_ACCESS_TOKEN_HERE" https://api.twitch.tv/helix/users?login= $+ $2-
  var %output = $read(user_id.txt)
  echo 4 -a usernotice rawmsg: $rawmsg
  echo -d Curl Output: %json($output,id).key
  lnbreak

  ; Read the response from the file
}
*/
lnbreak
alias userid {
  lnbreak
  return $read(user_id.txt, ns, $1)
  lnbreak
}

alias uid {
  //echo -d $read(user_id.txt)
}
/*
  if ($isfile(user_id.txt)) {
    var %id

    echo -d %id
    ; Read the broadcaster ID from the response (assuming JSON format)
    ; var %file = $file(user_id.txt, r)
    var %file = $read(user_id.txt, ns, $1)
    //echo -d 
    /**/
    while ($read(%file)) {
      if ($regex($readn, /"id":"(\d+)"/)) {
        %id = $regml(1)
        lnbreak
        echo -d %id
        lnbreak
        echo -a Broadcaster ID for %display_name %id
        close %file
        return
      }
    }
    echo -a Broadcaster ID not found for %channel
    close %file
    } else {
    echo -d Error: Failed to retrieve broadcaster ID
  }
  */
  
  ON *:TEXT:*:#: { echo $chan INFO: $nick -> $msgtags(account) -> $msgtags(msgid).tag -> $msgtags(msgid).key - Total: $msgtags(0) }
  
 