class SessionsController < ApplicationController
  def new
  	@cart = current_cart
  end

  def create
  	@account_member = AccountMember.authenticate(params[:session][:email], params[:session][:password])

  	if @account_member.blank?
  	  @cart = current_cart
  	  flash[:alert] = "Email/Password Salah"
  	  redirect_to root_path
      # redirect_to request.fullpath
  	else
  	  session[:user_id] = @account_member.id
  	  flash[:notice] = "Anda berhasil masuk"
  	  redirect_to root_path
  	end
  end

  def destroy
  	@cart = current_cart
  	# @line_items = LineItem.find_all_by_cart_id(@cart)
  	# @line_items.map(&:destroy)
  	# session[:cart_id] = nil
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Anda berhasil keluar"
  end
end
