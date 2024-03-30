alias parseCSV {
  ; Clear the previous content from the custom window
  if ($window(@CSVData)) {
    clear @CSVData
  }
  else {
    ; Open a new custom window to display the parsed CSV data
    window -e @CSVData
  }

  ; Use the /filter command to read and process each line of the CSV file
  filter -fk example.csv parseCSVLine
}

alias parseCSVLine {
  ; Check if the line is not empty
  if ($1-) {
    ; Split the line by commas and assign to variables
    var %name = $gettok($1-, 1, 44)
    var %age = $gettok($1-, 2, 44)
    var %country = $gettok($1-, 3, 44)

    echo @CSVData %name

    ; Echo the parsed data to the @CSVData window
    echo @CSVData Name: %name, Age: %age, Country: %country
  }
}

alias appendToCSVLine {
  ; Temporary file name for storing modified content
  var %tempFile = Temp/temp.csv
  ; Specify the line number you want to modify
  var %targetLine = 2 
  ; Data to append to the specified line
  var %appendData = ",apendedData" 

debugoutput $isfile(Temp/example.csv)

  ; Open the original CSV file to read
  if ($isfile(Temp/example.csv)) {
    var %lineNumber = 0
    ; var %file = $v1
    var %file = Temp/example.csv
      debugoutput %lineNumber $lines(%file) $v1.name
    while (%lineNumber != $lines(%file)) {
            debugoutput Bang 3
      inc %lineNumber
            debugoutput Debug - $+ %linenumber
      var %line = $read(%file, n, %lineNumber)
            debugoutput This line -  $+ %line
      ; Check if this is the line to modify
      ;debugoutput Debug $+ %targetLine $+ %targetLine
      lnbreak
      if (%lineNumber == %targetLine) {
              
        ; Append data to the line
        %line = %line $+ %appendData
              debugoutput Bang 7
      }
      
      ; Write the line to the temporary file
      write %tempFile %line
            debugoutput Bang 8
    }
    
    ; Replace the original file with the modified content
    .remove Temp/example.csv
    .rename %tempFile Temp/example.csv
    echo -a Appended data to line %targetLine in example.csv
  }
  else {
    echo -a The file example.csv does not exist.
  }
}