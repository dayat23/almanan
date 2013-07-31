module ApplicationHelper
  protected
  def authenticate
    unless (nil != session && nil != session[:user_id])
      flash[:alert] = "Anda harus login dahulu"
      redirect_to root_path
      return false
    end
  end

  def get_url_other
    @url = 'http://admin.local.host:9000'
  end
end
