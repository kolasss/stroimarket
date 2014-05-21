app.filter 'startFrom', () ->
  (input, start) ->
    if input?
      start = +start
      return input.slice(start)

