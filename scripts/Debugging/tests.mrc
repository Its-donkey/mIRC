alias lnbreak {
  linesep
  echo $1 |--------------------------------------------------------------------------------------|
  linesep
}

alias showtags {
  var %SN = 1
  var %ChanName = $upper($1) 

  debugoutput %ChanName 
  debugoutput $asctime($ctime, dd-mm-yyyy HH:nn:ss)
  debugoutput |-------------------------------------------------------------------|
  ;echo @Debug-Output @debug %ChanName
  while ($msgtags(%SN).tag) {
    debugoutput @debug . %SN $msgtags(%SN).tag $msgtags($msgtags(%SN).tag).key
    inc %SN
  }
  debugoutput |-------------------------------------------------------------------|
  linesep @Debug-Output
}

alias debugoutput {
  ; Check if custom window exists, if not, create it
  if (!$window(@Debug-Output)) {
    window -e @Debug-Output
  }


  ; Echo the message and sender's nick to the custom window
  echo @Debug-Output $1-

}