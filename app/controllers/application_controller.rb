class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def user_not_authorized
      # flash[:error] = "You are not authorized to perform this action."
      # redirect_to request.headers["Referer"] || root_path
      # redirect_to root_path, :status => :unauthorized, :error => "You are not authorized to perform this action."
      render file: "public/403", status: :unauthorized, layout: false
    end
end
