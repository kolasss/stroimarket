module ApplicationHelper
  def title new_title = nil
    if new_title.nil?
      content_for(:title)
    else
      content_for(:title) { new_title }
      new_title
    end
  end

  def full_title new_title = nil
    [ (new_title || title), t(:sitename) ].reject(&:blank?).join(' - ')
  end

  def localized_attribute model_name, attr_name
    t "#{model_name}.#{attr_name}", scope: 'simple_form.labels',
                                    default: "defaults.#{attr_name}".to_sym
  end

  def localized_role role
    t(role, scope: 'users.role')
  end

  def javascript_env
    js = ""
    js << "var system_info = {}"
    js << ";system_info.user = #{current_user.to_json(only:[:role])}"

    javascript_tag js
  end
end
