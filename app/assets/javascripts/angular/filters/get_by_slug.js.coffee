app.filter 'getBySlug', ->
  find = (array, slug) ->
    for element in array
      return element if element.slug == slug
      my_element = find(element.children, slug) if element.children.length > 0
    return my_element

  return (input_array, slug) ->
    find(input_array, slug)
