class AddStatusToAccountMember < ActiveRecord::Migration
  def change
    add_column :account_members, :status, :integer, default: 1
  end
end
