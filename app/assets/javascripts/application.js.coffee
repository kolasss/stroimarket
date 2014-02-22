#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require jquery_nested_form
#= require_tree .

# Uploaders.
($ '.image-uploader').each (i, el) ->
  new ImageUploader el: el

($ '.attachments-form').each (i, el) ->
  attachments = $ el

  attachments.find('.attachment').each (i, el) ->
    new AttachmentFields el: el

  attachments.find('.add-attachment').each (i, el) ->
    new AttachmentButton el: el
