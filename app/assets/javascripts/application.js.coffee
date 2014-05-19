#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require owl.carousel.min
#= require jquery_nested_form
#= require angular
#= require angular-route
#= require angular-resource
#= require textAngular-sanitize.min
#= require textAngular.min
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

  # $('.wysihtml5').each (i, elem) ->
  #   $(elem).wysihtml5
  #     locale: "ru-RU"
