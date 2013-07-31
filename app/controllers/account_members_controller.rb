class AccountMembersController < ApplicationController
  before_filter :authenticate, only: [:edit, :update]
  # GET /account_members
  # GET /account_members.json
  def index
    @cart = current_cart
    @account_members = AccountMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @account_members }
    end
  end

  # GET /account_members/1
  # GET /account_members/1.json
  def show
    @cart = current_cart
    @account_member = AccountMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account_member }
    end
  end

  # GET /account_members/new
  # GET /account_members/new.json
  def new
    @cart = current_cart
    @states = State.all
    i = 0
    for i in @states
      @name = []
      @states.each do |state|
        @name << state.name
      end
      @name
    end
    @role = Role.find_by_name("Member")
    @account_member = AccountMember.new(role_id: @role.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account_member }
    end
  end

  # GET /account_members/1/edit
  def edit
    @classe = "active"
    @cart = current_cart
    @account_member = AccountMember.find(params[:id])
  end

  # POST /account_members
  # POST /account_members.json
  def create
    @cart = current_cart
    @account_member = AccountMember.new(params[:account_member])

    respond_to do |format|
      if @account_member.save
        format.html { redirect_to root_path, notice: 'Daftar member berhasil disimpan' }
        format.json { render json: @account_member, status: :created, location: @account_member }
      else
        format.html { render action: "new" }
        format.json { render json: @account_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /account_members/1
  # PUT /account_members/1.json
  def update
    @cart = current_cart
    @account_member = AccountMember.find(params[:id])
    # firstname = params[:account_member][:first_name]
    # lastname = params[:account_member][:last_name]
    # email = params[:account_member][:email]
    # phone = params[:account_member][:phone]
    # address = params[:account_member][:address]
    # stateid = params[:account_member][:state_id]
    # cityid = params[:account_member][:city_id]

    respond_to do |format|
      if @account_member.update_attributes(params[:account_member])
      # if @account_member.update_attributes(first_name: firstname, last_name: lastname, email: email, phone: phone, address: address, state_id: stateid, city_id: cityid)
        format.html { redirect_to edituser_path(id: current_user), notice: 'Data pribadi berhasil disimpan' }
        format.json { head :no_content }
      else
        format.html { redirect_to edituser_path(id: current_user), alert: @account_member.errors }
        format.json { render json: @account_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_members/1
  # DELETE /account_members/1.json
  def destroy
    @cart = current_cart
    @account_member = AccountMember.find(params[:id])
    @account_member.destroy

    respond_to do |format|
      format.html { redirect_to account_members_url }
      format.json { head :no_content }
    end
  end
end
