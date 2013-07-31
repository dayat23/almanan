class ApplicationController < ActionController::Base
  protect_from_forgery
  # force_ssl
  helper_method :current_user
  include ApplicationHelper
  helper :all

  # rescue_from GoogCurrency::Exception do |exe|
  #   redirect_to root_path, alert: exe.message
  # end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActionController::RoutingError, :with => :render_not_found
  end 
 
  #called by last route matching unmatched routes.  Raises RoutingError which will be rescued from in the same way as other exceptions.
  def raise_not_found!
    # @cart = current_cart
    respond_to do |f| 
      # f.html{ render file: "#{Rails.root}/public/404", layout: false, status: 404 }
      f.html{ render 'pages/404', layout: false, status: 404 }
      # f.js{ render :partial => "errors/ajax_404", :status => 404 }
    end
    # raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end
 
  #render 500 error 
  def render_error(e)
    respond_to do |f| 
      f.html{ render file: "#{Rails.root}/public/500", layout: false, status: 500 }
      # f.js{ render :partial => "errors/ajax_500", :status => 500 }
    end
  end
  
  #render 404 error 
  def render_not_found(e)
    respond_to do |f| 
      f.html{ render file: "#{Rails.root}/public/404", layout: false, status: 404 }
      # f.js{ render :partial => "errors/ajax_404", :status => 404 }
    end
  end

  # rescue_from SocketError do |exception|
  #   respond_to do |f|
  #     f.html { render file: "#{Rails.root}/public/500", layout: false, status: 500 }
  #   end
  # end

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |f| 
      # f.html{ render file: "#{Rails.root}/public/404", layout: false, status: 404 }
      f.html{ render 'pages/404', layout: false, status: 404 }
      # f.js{ render :partial => "errors/ajax_404", :status => 404 }
    end
  end

  rescue_from ActiveRecord::DeleteRestrictionError do |exception|
    redirect_to root_path, alert: exception.message
  end

  private
  def current_cart
	 Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
  	cart = Cart.create
  	session[:cart_id] = cart.id
  	cart
  end
  helper_method :current_cart

  def current_user
    @current_user ||= AccountMember.find(session[:user_id]) if session[:user_id]
  end
end
