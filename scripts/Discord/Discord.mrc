; alias postapi {
  ; Open a socket to example.com on port 80 (HTTP)
  ;sockopen myapi discord.com 80
;}

on *:SOCKOPEN:myapi: {
  ; Check if the socket is opened successfully
  if ($sockerr) { echo -a Error opening socket to API. | return }

  ; Construct the POST request
  var %post = POST REPLACE_WITH_YOUR_WEBHOOK
  sockwrite -nt $sockname %post
  sockwrite -nt $sockname Host: discord.com
  sockwrite -nt $sockname Content-Type: application/json
  sockwrite -nt $sockname Content-Length: $len(%data)
  sockwrite -nt $sockname
  sockwrite -n $sockname %data
}

on *:SOCKREAD:myapi: {
  var %data
  sockread %data

  ; Process the response here
  echo -a Response from API: %data
}

; Example JSON data to send with the POST request
alias -l data return {"content": "Hello, from MIRC!"}


alias postapi {
  ; Set your API endpoint
  var %api_url = REPLACE_WITH_YOUR_WEBHOOK

  ; Set the data you want to send
  var %data = "{\"content\": \" > **Task 1 TODO**\n > Description: Make Barney a mod cause he is so amazing!\"}"

  var %dataA = "{\"content\": \"> #### Task 101 \n**Description:** Paint walls with primer.\\n**Due Date:** 28/06/2024\\n**Priority:** Medium\\n**Status:** Underway\\n\\n> _Posted by: OhmsLaw77_\\n> _Date created: 28/03/2023 11:45:42_\"}"

  var %dataAa = "{\"content\": \"this `supports` __a__ **subset** **of** *markdown* ~~markdown~~ 😃 \```js\nfunction foo(bar) {\n  console.log(bar);\n}\n\nfoo(1);\```\", \"embeds\": [{\"title\": \"title ~~(did you know you can have markdown here too?)~~\", \"description\": \"this supports [named links](https://discordapp.com) on top of the previously shown subset of markdown. \```\nyes, even code blocks\```\", \"url\": \"https://discordapp.com\", \"color\": 11038012, \"timestamp\": \"2020-07-03T15:05:41.392Z\", \"footer\": {\"icon_url\": \"https://cdn.discordapp.com/embed/avatars/0.png\", \"text\": \"footer text\"}, \"thumbnail\": {\"url\": \"https://cdn.discordapp.com/embed/avatars/0.png\"}, \"image\": {\"url\": \"https://cdn.discordapp.com/embed/avatars/0.png\"}, \"author\": {\"name\": \"author name\", \"url\": \"https://discordapp.com\", \"icon_url\": \"https://cdn.discordapp.com/embed/avatars/0.png\"}, \"fields\": [{\"name\": \"🤔\", \"value\": \"some of these properties have certain limits...\"}, {\"name\": \"😱\", \"value\": \"try exceeding some of them!\"}, {\"name\": \"🙄\", \"value\": \"an informative error should show up, and this view will remain as-is until all issues are fixed\"}, {\"name\": \"<:thonkang:219069250692841473>\", \"value\": \"these last two\", \"inline\": true}, {\"name\": \"<:thonkang:219069250692841473>\", \"value\": \"are inline fields\", \"inline\": true}]}]}"

  ; Call curl to make the POST request

  
  run cmd /c curl --location --request POST %api_url --header "Content-Type: application/json" --data-raw %dataAa -o response.txt



  ; Optionally, you can read the response from response.txt after a short delay
  .timer 1 3 readresponse
}

alias replaceQuotes {
  ; Your original string
  var %original = This is a "test" string with "quotes".

  ; Replace all " with \"
  var %modified = $replace(%original, ", \")

  ; Output the modified string
  echo -a %modified
} 

alias readresponse {
  if ($file(response.txt)) {
    var %file = $read(response.txt)
    echo -a API Response: %file
    ; Clean up
    remove response.txt
  }
}