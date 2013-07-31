class PhotoProductsController < ApplicationController
  # GET /photo_products
  # GET /photo_products.json
  def index
    @photo_products = PhotoProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photo_products }
    end
  end

  # GET /photo_products/1
  # GET /photo_products/1.json
  def show
    @photo_product = PhotoProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo_product }
    end
  end

  # GET /photo_products/new
  # GET /photo_products/new.json
  def new
    @photo_product = PhotoProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo_product }
    end
  end

  # GET /photo_products/1/edit
  def edit
    @photo_product = PhotoProduct.find(params[:id])
  end

  # POST /photo_products
  # POST /photo_products.json
  def create
    @photo_product = PhotoProduct.new(params[:photo_product])

    respond_to do |format|
      if @photo_product.save
        format.html { redirect_to @photo_product, notice: 'Photo product was successfully created.' }
        format.json { render json: @photo_product, status: :created, location: @photo_product }
      else
        format.html { render action: "new" }
        format.json { render json: @photo_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photo_products/1
  # PUT /photo_products/1.json
  def update
    @photo_product = PhotoProduct.find(params[:id])

    respond_to do |format|
      if @photo_product.update_attributes(params[:photo_product])
        format.html { redirect_to @photo_product, notice: 'Photo product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photo_products/1
  # DELETE /photo_products/1.json
  def destroy
    @photo_product = PhotoProduct.find(params[:id])
    @photo_product.destroy

    respond_to do |format|
      format.html { redirect_to photo_products_url }
      format.json { head :no_content }
    end
  end
end
