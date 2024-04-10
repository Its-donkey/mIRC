/*
mIRC integration with Discord script © 2024 by Jeffrey Shapiro is licensed under Attribution-NonCommercial-NoDerivs 4.0 International available at https://creativecommons.org/licenses/by-nc-nd/4.0/
*/

on *:START: {
      ; Check if the file exists
  if (!$isfile(mirc.ini)) {
    write -c mirc.ini
  }

  var %discordWebhook = $readini(mirc.ini, n, Discord, Webhook)
  if (%discordWebhook == $null) {
    %discordWebhook = $input(Enter your Discord Webhook URL,e,,,)
    writeini mirc.ini Discord Webhook %discordWebhook
  }

  var %taskNumber = $readini(mirc.ini, n, Discord, TaskNumber)
  if (%taskNumber == $null) {
    writeini mirc.ini Discord TaskNumber 1
  }
  else {
    inc %taskNumber 1
    writeini mirc.ini Discord TaskNumber %taskNumber
  }
}

on *:TEXT:!todo*:#moosedoesstuff: {
  var %taskNumber = $readini(mirc.ini, n, Discord, TaskNumber)
  inc %taskNumber 1
  writeini mirc.ini Discord TaskNumber %taskNumber
  
  var %usernick = $msgtags(display-name).key
  var %taskTime = \" $+ $asctime($ctime, yyyy-mm-dd) $+ T $+ $asctime($ctime, HH:nn:ss.000) $+ Z\",\"footer\":
  var %descriptionInput = $2-

  var %discordTaskData = "{\"embeds\": [{\"description\": \" %descriptionInput \",\"color\": 4419094,\"timestamp\": %taskTime {\"icon_url\": \"https://static-cdn.jtvnw.net/jtv_user_pictures/fb6710eb-92fe-4200-8d9b-d0886f9421fd-profile_image-70x70.png\",\"text\": \"Task created by %usernick \"},\"thumbnail\": {\"url\": \"https://static-cdn.jtvnw.net/jtv_user_pictures/fb6710eb-92fe-4200-8d9b-d0886f9421fd-profile_image-70x70.png\"},\"author\": {\"name\": \"Task Number %taskNumber \",\"icon_url\": \"https://cdn.discordapp.com/embed/avatars/0.png\"},\"title\": \"Description\"}]}"

  ; Call curl to make the POST request
  run cmd /c curl --location --request POST %discordWebhook --header "Content-Type: application/json" --data-raw %discordTaskData -o response.txt
}