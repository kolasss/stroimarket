app.filter 'priceRangeCatalog', ->
  (input_array = [], filter, type) ->
    if filter and (filter.minPrice or filter.maxPrice)
      filtered = []
      if filter.minPrice and filter.maxPrice
        angular.forEach input_array, (item) ->
          if item.price
            filtered.push(item) if item.price >= filter.minPrice and item.price <= filter.maxPrice
          else if item.min_price
            filtered.push(item) if item.min_price >= filter.minPrice and item.max_price <= filter.maxPrice

      else if filter.minPrice
        angular.forEach input_array, (item) ->
          if item.price
            filtered.push(item) if item.price >= filter.minPrice
          else if item.min_price
            filtered.push(item) if item.min_price >= filter.minPrice

      else if filter.maxPrice
        angular.forEach input_array, (item) ->
          if item.price
            filtered.push(item) if item.price <= filter.maxPrice
          else if item.min_price
            filtered.push(item) if item.max_price <= filter.maxPrice

      return filtered

    else
      return input_array
