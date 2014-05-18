#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require owl.carousel.min
#= require jquery_nested_form
#= require bootstrap-wysihtml5/b3
#= require bootstrap-wysihtml5/locales/ru-RU
#= require angular
#= require angular-route
#= require angular-resource
#= require angular_app
#= require_tree ./angular
#= require_tree .

jQuery ->
  # Uploaders.
  ($ '.image-uploader').each (i, el) ->
    new ImageUploader el: el

  ($ '.attachments-form').each (i, el) ->
    attachments = $ el

    attachments.find('.attachment').each (i, el) ->
      new AttachmentFields el: el

    attachments.find('.add-attachment').each (i, el) ->
      new AttachmentButton el: el

  # $('.dropdown-on-hover').hover(
  #   () ->
  #     $(this).addClass('open')
  #   () ->
  #     $(this).removeClass('open')
  # )

  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5()
