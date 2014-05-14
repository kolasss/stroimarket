app.filter 'manufacturerByCategory', ->
  get_id = (category) ->
      ids = [category.id]
      if category.children.length > 0
        for subcat in category.children
          ids = ids.concat get_id(subcat)
      return ids

  return (input_array, category) ->
    categories_ids = get_id(category)

    filtered = []

    angular.forEach input_array, (item) ->
      for cat in item.category_ids
        if categories_ids.indexOf(cat.$oid) > -1
          filtered.push(item)
          break

    return filtered
