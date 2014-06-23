jQuery ->
  $('.category_tree input:radio').change ->
    category_id = @value
    object_id = $(@).parents('.category_tree')[0].getAttribute('object_id')

    # Часть для кастомных полей
    custom_attributes = $('.custom_attributes')

    $.ajax
      url: '/admin/products/custom_category_fields'
      data:
        category_id: category_id
        object_id: object_id
      success: (res, status, xhr) ->
        custom_attributes.html res
    # - Конец - Часть для кастомных полей

    manufacturer_field = $('.manufacturer_field')

    $.ajax
      url: '/admin/products/manufacturer_field'
      data:
        category_id: category_id
        object_id: object_id
      success: (res, status, xhr) ->
        manufacturer_field.html res

  $(".category_tree i+ul").hide()
  $(".category_tree i").click ->
    $(this).toggleClass('fa-angle-down fa-angle-up')
    # $(this).toggleClass('fa-angle-up')
    $(this).next("ul").toggle()
