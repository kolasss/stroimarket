app.filter 'productByCategory', ->
  (input_array, filter) ->
    if filter.subcats.length > 0
      filtered = []
      for item in input_array
        filtered.push(item) if item.category_id.$oid in filter.subcats
      return filtered
    else
      return input_array

