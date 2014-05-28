app.filter 'productByCategory', ->
  (input_array, filter) ->
    if filter.subcats.length > 0
      filtered = []
      angular.forEach input_array, (item) ->
        filtered.push(item) if filter.subcats.indexOf(item.category_id.$oid) > -1
      return filtered
    else
      return input_array

