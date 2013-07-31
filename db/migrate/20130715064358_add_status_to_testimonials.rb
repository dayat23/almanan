class AddStatusToTestimonials < ActiveRecord::Migration
  def change
    add_column :testimonials, :status, :integer, default: 0
  end
end
