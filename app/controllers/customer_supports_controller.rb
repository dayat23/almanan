class CustomerSupportsController < ApplicationController
  # GET /customer_supports
  # GET /customer_supports.json
  def index
    @customer_supports = CustomerSupport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customer_supports }
    end
  end

  # GET /customer_supports/1
  # GET /customer_supports/1.json
  def show
    @customer_support = CustomerSupport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer_support }
    end
  end

  # GET /customer_supports/new
  # GET /customer_supports/new.json
  def new
    @customer_support = CustomerSupport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer_support }
    end
  end

  # GET /customer_supports/1/edit
  def edit
    @customer_support = CustomerSupport.find(params[:id])
  end

  # POST /customer_supports
  # POST /customer_supports.json
  def create
    @customer_support = CustomerSupport.new(params[:customer_support])

    respond_to do |format|
      if @customer_support.save
        format.html { redirect_to @customer_support, notice: 'Customer support was successfully created.' }
        format.json { render json: @customer_support, status: :created, location: @customer_support }
      else
        format.html { render action: "new" }
        format.json { render json: @customer_support.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customer_supports/1
  # PUT /customer_supports/1.json
  def update
    @customer_support = CustomerSupport.find(params[:id])

    respond_to do |format|
      if @customer_support.update_attributes(params[:customer_support])
        format.html { redirect_to @customer_support, notice: 'Customer support was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer_support.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_supports/1
  # DELETE /customer_supports/1.json
  def destroy
    @customer_support = CustomerSupport.find(params[:id])
    @customer_support.destroy

    respond_to do |format|
      format.html { redirect_to customer_supports_url }
      format.json { head :no_content }
    end
  end
end
