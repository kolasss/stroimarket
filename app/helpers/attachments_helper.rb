module AttachmentsHelper
  def button_to_add_attachment title, form, association, options = {}, &blk
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    tpl = form.simple_fields_for(association, new_object, child_index: id) do |f|
      blk.call(f, new_object)
    end

    options.reverse_merge! data: { 'id' => id, 'item-tpl' => tpl.to_str }
    content_tag :button, title, options
  end

  def button_to_add_document f, &blk
    btn = "#{icon 'file'} #{t 'documents.add'}"
    classes = 'btn btn-default add-attachment add-document'

    button_to_add_attachment(raw(btn), f, :documents, class: classes, &blk)
  end

  def button_to_add_image f, &blk
    btn = "#{icon 'picture'} #{t 'images.add'}"
    classes = 'btn btn-default add-attachment add-image'

    button_to_add_attachment(raw(btn), f, :images, class: classes, &blk)
  end
end