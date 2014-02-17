class CategoryInput < SimpleForm::Inputs::Base
# class CategoryInput < SimpleForm::Inputs::StringInput
  def input
    # "$ #{@builder.text_field(attribute_name, input_html_options)}".html_safe
    input_html_options[:class] << "form-control"

    class_name = @builder.object.class.name.underscore
    input_html_options[:id] ||= "#{class_name}_#{attribute_name}"
    input_html_options[:name] ||= "[#{class_name}]#{attribute_name}"

    value = @builder.object ? @builder.object[attribute_name] : nil

    if options[:type] == 'string'
      template.text_field_tag(attribute_name, value, input_html_options)
    elsif options[:type] == 'boolean'
      input_html_options[:checked] = false unless value
	    template.check_box(class_name, attribute_name, input_html_options, 'true', 'false')
    elsif options[:type] == 'integer'
    	template.number_field_tag(attribute_name, value, input_html_options)
  	else
  		raise NotImplementedError
    end

    # @builder.object.send(attribute_name)

    # "attribute_name #{attribute_name}
    #  input_type #{input_type}
    #  options #{options}
    #  input_html_options #{input_html_options}
    # "
  end
end
