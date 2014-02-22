class ImageSizeValidator < ActiveModel::EachValidator
  CHECKS = [
    { key: :width,  field: :width,  method: :'==', message: :width_must_be  },
    { key: :height, field: :height, method: :'==', message: :height_must_be },

    { key: :min_width,  field: :width,  method: :'>=', message: :width_must_be_at_least  },
    { key: :min_height, field: :height, method: :'>=', message: :height_must_be_at_least },

    { key: :max_width,  field: :width,  method: :'<=', message: :width_must_be_at_most  },
    { key: :max_height, field: :height, method: :'<=', message: :height_must_be_at_most }
  ].freeze

  def initialize options
    [ :width, :height ].each do |opt|
      if options[opt].kind_of?(Range)
        range = options.delete(opt)

        options[:"min_#{opt}"] = range.begin
        options[:"max_#{opt}"] = range.exclude_end? ? range.end - 1 : range.end
      end
    end

    super
  end

  def validate_each record, attribute, value
    dim = image_dimensions(record, attribute, value)

    CHECKS.each do |check|
      key, field = check[:key], check[:field]

      if options[key] and not dim[field].send(check[:method], options[key])
        message = options[:message] || check[:message]
        record.errors.add(attribute, message, options)
      end
    end
  end

  protected

  def image_dimensions record, attribute, value
    if dimensions = record.try("#{attribute}_meta")
      dimensions.symbolize_keys
    else
      img = MiniMagick::Image.open(value.path)
      Hash[[ :width, :height ].zip(img[:dimensions])]
    end
  end
end
