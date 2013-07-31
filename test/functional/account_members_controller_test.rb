require 'test_helper'

class AccountMembersControllerTest < ActionController::TestCase
  setup do
    @account_member = account_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_member" do
    assert_difference('AccountMember.count') do
      post :create, account_member: { address: @account_member.address, city_id: @account_member.city_id, email: @account_member.email, encrypted_password: @account_member.encrypted_password, first_name: @account_member.first_name, last_name: @account_member.last_name, phone: @account_member.phone, role_id: @account_member.role_id, salt: @account_member.salt, state_id: @account_member.state_id }
    end

    assert_redirected_to account_member_path(assigns(:account_member))
  end

  test "should show account_member" do
    get :show, id: @account_member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account_member
    assert_response :success
  end

  test "should update account_member" do
    put :update, id: @account_member, account_member: { address: @account_member.address, city_id: @account_member.city_id, email: @account_member.email, encrypted_password: @account_member.encrypted_password, first_name: @account_member.first_name, last_name: @account_member.last_name, phone: @account_member.phone, role_id: @account_member.role_id, salt: @account_member.salt, state_id: @account_member.state_id }
    assert_redirected_to account_member_path(assigns(:account_member))
  end

  test "should destroy account_member" do
    assert_difference('AccountMember.count', -1) do
      delete :destroy, id: @account_member
    end

    assert_redirected_to account_members_path
  end
end
