class FileSizeValidator < ActiveModel::EachValidator
  CHECKS = [
    { key: :is,      method: :==, message: :wrong_size     },
    { key: :minimum, method: :>=, message: :size_too_small },
    { key: :maximum, method: :<=, message: :size_too_big   }
  ].freeze

  def initialize options
    if range = (options.delete(:in) or options.delete(:within))
      unless range.is_a?(Range)
        raise ArgumentError, ':in and :within must be a Range'
      end

      options[:minimum] = range.begin
      options[:maximum] = range.exclude_end? ? range.end - 1 : range.end
    end

    super
  end

  def validate_each record, attribute, value
    CHECKS.each do |check|
      key = check[:key]

      # p '==================='
      # p key
      # p check[:method]
      # p options[key]
      # p value
      # p value.size
      # p value.file.exists?
      # p value.file.content_length

      if value.file.exists? and options[key] and not value.size.send(check[:method], options[key])
        message = options[:message] || check[:message]

        opts = options.dup
        opts[:file_size] = number_to_human_size(options[key])

        record.errors.add(attribute, message, opts)
      end
    end
  end

  protected

  def number_to_human_size value
    Helper.instance.number_to_human_size(value)
  end

  class Helper
    include Singleton
    include ActionView::Helpers::NumberHelper
  end
end
