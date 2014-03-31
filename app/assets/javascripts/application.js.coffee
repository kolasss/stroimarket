#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require jquery_nested_form
#= require ckeditor/init
#= require angular
#= require angular-resource
#= require abn_tree_directive
#= require angular_app
#= require_tree ./angular
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
