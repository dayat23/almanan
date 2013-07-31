class OrdersController < ApplicationController
  require 'money'
  require 'money/bank/google_currency'
  require 'active_merchant'

  # GET /orders
  # GET /orders.json
  def index
    @cart = current_cart
    @orders = Order.all

    @user = current_user

    if @user.blank?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @orders }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_order_path }
      end
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @cart = current_cart
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    # @url = "http://rate-exchange.appspot.com/currency?from=IDR&to=USD"
    @cart = current_cart
    @cart.line_items.each do |item|
      @productid = item.product.id
    end
    @destinations = Destination.find(:all, group: "state_id")
    # @states = State.find(:all, conditions: { state_status: 1 })
    @states = State.find(:all, conditions: { state_status: 1 })

    @user = current_user
    if @user.blank?
      @order = Order.new(cart_id: @cart.id)
    else
      @order = Order.new(account_member_id: @user.id, cart_id: @cart.id)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @cart = current_cart
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @cart = current_cart
    @desti = Destination.find(params[:order][:destination_id])
    alltotal_price = @desti.price + @cart.total_price
    @order = Order.new(params[:order])
    @order.total_all(alltotal_price)

    respond_to do |format|
      if @order.save
        if @order.purchase
          # if @order.save
            # render :action => "success"
            @cart.line_items.each do |item|
              item.order_id = @order.id
              item.save!
            end

            session[:cart_id] = nil

            format.html { redirect_to root_path, notice: 'Order berhasil, tunggu untuk konfirmasi selanjutnya' }
            format.json { render json: @order, status: :created, location: @order }
          # else
          #   format.html { redirect_to root_path, alert: response.message }
          # end
        else
          # render :action => "failure"
          format.html { redirect_to root_path, alert: 'Pembayaran gagal' }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @cart = current_cart
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @cart = current_cart
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def dynamic_price
      @cart = current_cart
      @desti = Destination.find(params[:id])

      ret = "$('#destination_price').empty();"
      total = "$('#total_total_price').empty();"

      alltotal_price = @desti.price + @cart.total_price

      # ret << "$('#destination_price').append($('<input>').attr('value',#{@desti.price}));"
      ret << "$('#destination_price').val(accounting.formatMoney(#{@desti.price}, 'Rp. ', 0, '.', ','));"
      total << "$('#total_total_price').val(accounting.formatMoney(#{alltotal_price}, 'Rp. ', 0, '.', ','));"

      render js: [ret, total]
  end
end
