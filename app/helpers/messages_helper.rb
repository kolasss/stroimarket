module MessagesHelper
  def messages
    safe_join flash.map { |type, msg| message(type, msg) }
  end

  def message type, msg
    msg = safe_join([ icon_close(:alert), msg ])

    content_tag :div, msg, class: "alert fade in #{message_class type}"
  end

  def message_class type
    case type
    when :info    then 'alert-info'
    when :notice  then 'alert-info'
    when :warning then 'alert-warning'
    when :alert   then 'alert-danger'
    when :danger  then 'alert-danger'
    end
  end
end
