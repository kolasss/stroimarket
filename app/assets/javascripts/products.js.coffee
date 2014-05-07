$('#product_category_id').change ->
  category_id = this.value
  object_id = this.getAttribute('object_id')

  # Часть для кастомных полей
  # target = $('.custom_attributes')

  # $.ajax
  #   url: '/products/custom_category_fields'
  #   data:
  #     category_id: category_id
  #     object_id: object_id
  #   success: (res, status, xhr) ->
  #     target.html res
  # - Конец - Часть для кастомных полей

  target = $('.manufacturer_field')

  $.ajax
    url: '/products/manufacturer_field'
    data:
      category_id: category_id
      object_id: object_id
    success: (res, status, xhr) ->
      target.html res
