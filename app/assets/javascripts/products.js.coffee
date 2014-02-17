# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#product_category_id').change ->
  category_id = this.value
  object_id = this.getAttribute('object_id')

  target = $('.custom_attributes')

  $.ajax
    url: '/products/custom_category_fields'
    data:
      category_id: category_id
      object_id: object_id
    success: (res, status, xhr) ->
      target.html res
