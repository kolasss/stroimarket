class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    # redirect_to root_path, :status => :unauthorized, :alert => exception.message
    render file: "public/403", status: :unauthorized, layout: false
  end
end
