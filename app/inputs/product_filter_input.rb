class ProductFilterInput < SimpleForm::Inputs::Base
  def input
    set_default_options input_html_options

    value = @builder.object ? @builder.object[attribute_name] : nil

    case options[:type]
    when 'boolean'
      template.check_box(@class_name, attribute_name, input_html_options, 'true', 'false')
    when 'string'
      template.text_field_tag(attribute_name, value, input_html_options)
    when 'integer'
      min_max_input attribute_name, value, input_html_options
    else
      raise NotImplementedError
    end
  end

  private
    def set_default_options input_html_options
      input_html_options[:class] << "form-control"

      @class_name = @builder.object.class_name

      symbol_name = @builder.object.symbol_name

      input_html_options[:id] ||= "#{@class_name}_#{symbol_name}_#{attribute_name}"
      input_html_options[:name] ||= "[#{@class_name}]#{attribute_name}"
    end

    def min_max_input attribute_name, value, input_html_options
      input_html_options[:name] = "[#{@class_name}]#{attribute_name}[min]"
      min_value = value.try(:min) ? value[:min] : nil
      min_input = template.number_field_tag(attribute_name, min_value, input_html_options)

      input_html_options[:id] += "_max"
      input_html_options[:name] = "[#{@class_name}]#{attribute_name}[max]"
      max_value = value.try(:max) ? value[:max] : nil
      max_input = template.number_field_tag(attribute_name, max_value, input_html_options)

      %{<div class="rangeblock">
        <div class="inputblock">
          #{min_input}
          <span class="dash">&mdash;</span>
          #{max_input}
          <span class="measure">#{options[:measure]}</span>
        </div>
      </div>}
    end

  # def range_input object, attribute, measure, show_label: true, show_checkbox: false
  #   # if param = params[attribute]
  #   #   min, max = param.split('-')
  #   # end

  #   if show_label
  #     if show_checkbox
  #       label = "<label for='#{attribute}-checkbox' class='checkbox'><input id='#{attribute}-checkbox' class='label-checkbox' type='checkbox'>#{options[:label]}</label>"
  #     else
  #       label = "<label for='#{attribute}-checkbox'>#{options[:label]}</label>"
  #     end
  #   end

  #   %{
  #     <div class="rangeblock">
  #       #{label}
  #       <div class="inputblock">
  #         <input class="min form-control" value="#{}">
  #         <span class="dash">&mdash;</span>
  #         <input class="max form-control" value="#{}">
  #         <span class="measure">#{measure}</span>
  #       </div>
  #       #{}
  #       <div id="#{attribute}-range"></div>
  #       <div class="minmax">
  #         <span class="pull-left">min</span>
  #         <span class="pull-right">max</span>
  #       </div>
  #     </div>
  #   }
  # end
end
