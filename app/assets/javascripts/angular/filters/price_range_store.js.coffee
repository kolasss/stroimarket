app.filter 'priceRangeStore', ->
  (input_array, filter) ->
    filtered = []
    if filter
      angular.forEach input_array, (item) ->
        if item.price
          if filter.minPrice and filter.maxPrice
            filtered.push(item) if item.price >= filter.minPrice and item.price <= filter.maxPrice
          else if filter.minPrice
            filtered.push(item) if item.price >= filter.minPrice
          else if filter.maxPrice
            filtered.push(item) if item.price <= filter.maxPrice

    return if filter and (filter.minPrice or filter.maxPrice)
      filtered
    else
      input_array

