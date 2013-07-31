class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.integer :account_member_id
      t.text :description

      t.timestamps
    end
  end
end
