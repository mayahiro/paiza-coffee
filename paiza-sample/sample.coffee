input = ''

process.stdin.resume()

process.stdin.setEncoding 'utf8'

process.stdin.on 'data', (chunk) ->
  input += chunk

process.stdin.on 'end', ->
  lines = input.split '\n'

  lineCount = parseInt lines[0], 10

  for i in [1...lineCount + 1]
    year = parseInt lines[i], 10
    if year % 4 is 0 and (year % 100 isnt 0 or year % 400 is 0)
      console.log "#{year} is a leap year"
    else
      console.log "#{year} is not a leap year"
