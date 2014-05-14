app.filter 'getBySlug', ->
  find = (array, slug) ->
    for element in array
      if element.slug == slug
        return element
      else if element.children? and element.children.length > 0
        my_element = find(element.children, slug)
        break if my_element?
    return my_element

  return (input_array, slug) ->
    find(input_array, slug)
