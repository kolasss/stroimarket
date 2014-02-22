module ImagesHelper
  def image_uploader form, options = {}
    attr_name = (options[:attr_name] or :image)
    class_name = (options[:class_name] or attr_name)
    value = form.object.send(attr_name)

    image_preview = image_tag (value.present? ? value : ''), class: 'image-preview'
    file_input    = form.file_field attr_name,               class: 'image-file', accept: 'image/jpg, image/jpeg, image/png'
    remove_input  = form.hidden_field "remove_#{attr_name}", class: 'image-remove'
    remove_button = icon_close
    errors        = form.error(attr_name)

    raw %{
      <div class="image-uploader #{class_name}-uploader">
        #{image_preview}
        #{file_input}
        #{remove_input}
        #{remove_button}
      </div>
      #{errors}
    }
  end

  def cover_uploader f
    image_uploader f, attr_name: 'cover'
  end
end
