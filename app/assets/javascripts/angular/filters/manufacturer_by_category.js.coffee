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

    for item in input_array
      for cat in item.category_ids
        if cat.$oid in categories_ids
          filtered.push(item)
          break

    return filtered
