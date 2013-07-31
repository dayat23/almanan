class ReviewProductsController < ApplicationController

  def index
  end

  def show
  end

  def new

  end

  def create
    @cart = current_cart
    @review_product = ReviewProduct.new(params[:review_product])

    respond_to do |format|
      if @review_product.save
        format.html { redirect_to detail_product_path(@review_product.product), notice: 'Review produk berhasil disimpan' }
        format.json { render json: @review_product, status: :created, location: @review_product }
      else
        format.html { redirect_to detail_product_path(@review_product.product), alert: @review_product.errors.messages }
        format.json { render json: @review_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
