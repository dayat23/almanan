class PagesController < ApplicationController

  def index
    @cart = current_cart
    @products = Product.product_sale
    @products = Kaminari.paginate_array(@products).page(params[:page]).per(12)
  end

  def kategori
  	@cart = current_cart
    @categories = Category.find(:all, conditions: { status: 1 })
    @namecategory = []
    @products = Product.product_sale
    # @products2 = Kaminari.paginate_array(@products).page(params[:page]).per(1)
    # @products1 = Kaminari.paginate_array(@products).page(params[:page]).per(2)
  end

  # def contact_us
  # 	@cart = current_cart
  # end

  def detail_product
  	@cart = current_cart
    @user = current_user
    @product = Product.find(params[:id])

    @image = PhotoProduct.find_all_by_product_id(@product.id).first
    if @user
      @review_product = ReviewProduct.new(product_id: @product.id, account_member_id: @user.id)
    else
      @review_product = ReviewProduct.new(product_id: @product.id)
    end

    ViewedProduct.viewed(@product.id)

    respond_to do |format|
      format.html { render 'pages/detail_product' }
    end
  end

  def how_order
  	@cart = current_cart
  end

  def sitemap
  	@cart = current_cart
    @products = Product.product_sale
  end

  def update_quantity_cart
    @cart = current_cart
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if params[:item][:quantity].to_i > @line_item.product.stock.to_i
        format.html { redirect_to carts_path, alert: "Quantity yang dimasukkan melebihi stok (stok tersedia #{@line_item.product.stock})" }
        format.json { head :no_content }
      else
        if @line_item.update_attribute :quantity, params[:item][:quantity]
          format.html { redirect_to carts_path, notice: 'Quantity berhasil diubah' }
          format.json { head :no_content }
        else
          format.html { redirect_to carts_path, notice: 'Quantity gagal diubah' }
          format.json { head :no_content }
        end
      end
    end
  end

  def delete_item_cart
    @cart = current_cart
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.destroy
        # Product.find(@line_item.product_id).increment_stock(@line_item.quantity, @line_item.product_id)
        format.html { redirect_to carts_path, notice: 'Item berhasil dihapus' }
        format.json { head :no_content }
      else
        format.html { redirect_to carts_path, notice: 'Item gagal dihapus' }
        format.json { head :no_content }
      end
    end
  end

  def category_detail
    @cart = current_cart
    @categories = Category.find(:all, conditions: { status: 1 })
    @category = Category.find(params[:id])
    @namecategory = @category.name
    @products = @category.products.product_sale
    # @products2 = Kaminari.paginate_array(@products).page(params[:page]).per(9)
    # @products1 = Kaminari.paginate_array(@products).page(params[:page]).per(3)

    respond_to do |format|
      format.html { render 'pages/kategori'}
    end
  end

  def category_detail_view
    @cart = current_cart
    # @review_product = ReviewProduct.new
    @line_items = LineItem.find(:all, conditions: { cart_id: @cart })
    # @testimonials = Testimonial.find(:all, conditions: {status: 1}, limit: 5, order: "created_at DESC")
    @product = Product.find(params[:id])
    # @reviewproducts = @product.review_products
    if @line_items.blank?
      @quantity = 0
    else
      for item in @line_items
        @quantity = item.quantity
      end
    end

    respond_to do |format|
      format.html { render 'pages/detail_product' }
    end
  end

  def dynamic_cities
      @cart = current_cart
      @cities = City.find_all_by_state_id(params[:id])

      @kotatujuan = Destination.find_all_by_state_id(params[:id])

      ret = "$('#account_member_city_id').empty();"
      cit = "$('#city_city_id').empty();"
      ter = "$('#order_destination_id').empty();"
      ong = "$('#destination_price').empty();"
      total = "$('#total_total_price').empty();"
      @id = []
      @cities.each do |city| 
        cit << "$('#city_city_id').append($('<option></option>').attr('value',#{city.id.to_s}).text('#{city.name}'));"
        ret << "$('#account_member_city_id').append($('<option></option>').attr('value',#{city.id.to_s}).text('#{city.name}'));"
      end

      if @kotatujuan.blank?
        ong << "$('#destination_price').val('0');"
        ter << "$('#order_destination_id').append($('<option></option>').attr('value', '').text('-- Pilih Kota Tujuan --'));"
      else
        @kotatujuan.each do |kota|
          ter << "$('#order_destination_id').append($('<option></option>').attr('value',#{kota.id.to_s}).text('#{kota.name}'));"
          @id << kota.id
          # ong << "$('#destination_price').append($('<option></option>').attr('value', #{desti.price}).text('#{desti.price}'));"

        end
        @desti = Destination.find(@id[0])
        alltotal_price = @desti.price + @cart.total_price
        ong << "$('#destination_price').val(accounting.formatMoney(#{@desti.price}, 'Rp. ', 0, '.', ','));"
        total << "$('#total_total_price').val(accounting.formatMoney(#{alltotal_price}, 'Rp. ', 0, '.', ','));"
      end

      render js: [ret, ter, ong, cit, total]
  end

  # def view_category
  #   @cart = current_cart
  #   @categories = Category.find(:all, conditions: { status: 1 })
  #   @namecategory = []
  #   @products = Product.product_sale
  #   @products2 = Kaminari.paginate_array(@products).page(params[:page]).per(9)
  #   @products1 = Kaminari.paginate_array(@products).page(params[:page]).per(1)

  #   respond_to do |format|
  #     format.html { render 'pages/kategori' }
  #   end
  # end

  def new_password
    @cart = current_cart
    respond_to do |format|
      format.html { render 'pages/new_password' }
    end
  end

  def create_newpassword
    email = params[:email]

    if email.blank?
      respond_to do |format|
        format.html { redirect_to lupapassword_path, alert: 'Email tidak boleh kosong' }
      end
    else
      if valid_email?(email)
        @accountmember = AccountMember.find_by_email(email)

        if @accountmember.blank?
          respond_to do |format|
            format.html { redirect_to lupapassword_path, alert: 'Email yang dimasukkan tidak ditemukan' }
          end
        else
          # password = SecureRandom.hex(8)
          password = "welehweleh1"
          
          respond_to do |format|
            if @accountmember.update_attributes(password: password)

              format.html { redirect_to lupapassword_path, notice: 'Password sudah dikirim email' }
            else
              format.html { redirect_to lupapassword_path, alert: 'Error' }
            end
          end
        end
        
      else
        respond_to do |format|
          format.html { redirect_to lupapassword_path, alert: 'Email tidak valid' }
        end
      end
    end
  end

  def hit_rank
    @cart = current_cart
    @viewed_products = ViewedProduct.order("total DESC")

    respond_to do |format|
      format.html
    end
  end

  def product_cheap
    @cart = current_cart
    @cheaps = Product.where("stock > ?",0).order("price")

    respond_to do |format|
      format.html
    end
  end

  def product_high
    @cart = current_cart
    @highs = Product.where("stock > ?",0).order("price DESC")

    respond_to do |format|
      format.html
    end
  end
  
  private
  def valid_email?(email)
    if email.match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
      return true
    end
  end
end
