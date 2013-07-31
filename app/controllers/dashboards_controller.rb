class DashboardsController < ApplicationController
  before_filter :authenticate

  def index
  	@cart = current_cart
  end

  def show_order
    @classo = "active"
    @cart = current_cart
    @user = current_user
    @orders = Order.find(:all, conditions: ["account_member_id = ? AND status != ?", @user.id, -1])
  end

  def edit_password
    @classg = "active"
  	@cart = current_cart
  	@userid = current_user.id
  	respond_to do |f|
  		f.html { render 'dashboards/edit_password' }
  	end
  end

  def update_password
  	@account_member = AccountMember.find(params[:id])
  	newpassword = params[:new_password]
  	newpasswordconfirm = params[:new_password_confirmation]

  	if newpassword.blank?
  		redirect_to editpassword_path, alert: 'Password tidak boleh kosong'
  	elsif newpasswordconfirm.blank?
  		redirect_to editpassword_path, alert: 'Password konfirmasi tidak boleh kosong'
  	elsif newpassword != newpasswordconfirm
  		redirect_to editpassword_path, alert: 'Password dan password konfirmasi tidak sama'
  	elsif newpassword.length < 6
  		redirect_to editpassword_path, alert: 'Password minimal 6 karakter'
  	else
  		@account_member.update_attributes(password: newpassword)
  		redirect_to editpassword_path, notice: 'Ubah password berhasil'
  	end
  end

  def cancel_order
    @cancel = Order.find_by_id(1)

    respond_to do |format|
      if @cancel.cancel_order!
        format.html { redirect_to daftarorder_path, notice: "Batal order berhasil" }
      else
        format.html { redirect_to daftarorder_path, alert: 'Gagal' }
      end
    end
  end
end
