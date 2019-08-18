class AddOvertimeRequestToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :overtime_request, :decimal, precision: 4, scale: 2, default: 0.0
  end
end
