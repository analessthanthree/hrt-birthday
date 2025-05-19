#! /usr/bin/nu

def main [
  --birthday_only (-b)
] {
    let start_date_string = "2022-08-26"

    let today = date now
    let start_date = ( $start_date_string | date from-human )
    let dur = $today - $start_date

    let birthday = ( $today | format date "%m%d" ) == ( $start_date | format date "%m%d" )
    if $birthday {
      figlet "HAPPY BIRTHDAY!!!" | pridecat --transgender
    }

    if $birthday_only {
      exit
    }

    let years = $dur 
      | format duration yr
      | split row " "
      | $in.0
      | into float
    let years_whole = $years | math floor
    let years_decimal = $years - $years_whole | math round -p 3

    let leftover_days = $years_decimal * 52
      | into string
      | $"($in)wk"
      | into duration
      | format duration day
      | split row " "
      | $in.0
      | into int

    print $"You've been on HRT for ($years_whole) years and ($leftover_days) days!"
  }
