class UpdateStatusCodeInResponses < ActiveRecord::Migration
  def change
    change_column :responses, :status_code, :integer, :default => 200
  end
end
