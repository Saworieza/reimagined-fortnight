class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionController::UnknownController, with: -> { render_404  }
  rescue_from ActiveRecord::RecordNotFound,        with: -> { render_404  }
  
  # You want to get exceptions in development, but not in production.
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: -> { render_404  }
  end

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/not_found', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  # rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  # def render_404(notice = nil, template_path = "404", options = {})
  #   byebug
  #   options[:is_relative_path] = true if options[:is_relative_path].nil?

  #   if notice.present?
  #     logger = Logger.new "#{Rails.root}/log/404_exceptions.log"
  #     logger.info notice.backtrace.join("\n")
  #     logger.info 
  #   end
  #   file_path = options[:is_relative_path] ? "#{Rails.root}/public/#{template_path}.html" : template_path
  #   respond_to do |format|
  #     format.html {render file: file_path, status: :not_found, layout: false}
  #     format.json {render status: :not_found, json: { error: t(:resource_not_found) } }
  #     format.api { render json: { errors: t(:resource_not_found) }, status: 403 }
  #     format.any { head status: :not_found }
  #   end
  # end


  protected

  def configure_permitted_parameters
  	added_attrs = [:name, :email, :about, :location, :website, :avatar, :cover, :username, :verified, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
