app.filter 'productByManufacturer', ->
  (input_array, filter) ->
    if filter.manufacturers.length > 0
      filtered = []
      angular.forEach input_array, (item) ->
        filtered.push(item) if filter.manufacturers.indexOf(item.manufacturer_title) > -1
      return filtered
    else
      return input_array

