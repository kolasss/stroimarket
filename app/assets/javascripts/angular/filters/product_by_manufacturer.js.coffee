app.filter 'productByManufacturer', ->
  (input_array = [], filter) ->
    if filter.manufacturers.length > 0
      filtered = []
      for item in input_array
        filtered.push(item) if item.manufacturer_title in filter.manufacturers
      return filtered
    else
      return input_array

