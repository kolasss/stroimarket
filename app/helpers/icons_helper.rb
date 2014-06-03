module IconsHelper
  # def glyphicon name
  #   content_tag :span, '', class: "glyphicon glyphicon-#{name}"
  # end

  def icon_link name, href, options = {}
    link_to href, options do
      fa_icon name
    end
  end

  def icon_close dismiss = ''
    # content_tag(:button, '×', class: 'close', data: { dismiss: dismiss })
    fa_icon 'times-circle', class: 'close', data: { dismiss: dismiss }
  end

  # def icon_boolean value
  #   content_tag(:span, value ? '✓' : '×', class: "boolean_icon #{!!value}")
  # end

  def icon_ruble
    # content_tag(:span, 'Р', class: "rouble")
    fa_icon 'rub'
  end

  # alias_method :icon, :glyphicon
end
