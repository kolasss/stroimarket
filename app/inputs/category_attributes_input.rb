class CategoryAttributesInput < SimpleForm::Inputs::Base
  def input
    set_default_options input_html_options

    value = @builder.object ? @builder.object[attribute_name] : nil

    case options[:type]
    when 'list'
      the_array = JSON.parse(options[:unit])
      template.select_tag(attribute_name, template.options_for_select(the_array, value), input_html_options)
    when 'boolean'
      input_html_options[:checked] = false unless value
      template.check_box(@class_name, attribute_name, input_html_options, 'true', 'false')
    when 'integer'
      template.number_field_tag(attribute_name, value, input_html_options)
    when 'string'
      template.text_field_tag(attribute_name, value, input_html_options)
    else
      raise NotImplementedError
    end
  end

  private
    def set_default_options input_html_options
      input_html_options[:class] << "form-control"

      @class_name = @builder.object.class.name.underscore

      input_html_options[:id] ||= "#{@class_name}_#{attribute_name}"
      input_html_options[:name] ||= "[#{@class_name}]#{attribute_name}"
    end
end
