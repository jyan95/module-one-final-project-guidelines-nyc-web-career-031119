class AddRightwrongColumnToQm < ActiveRecord::Migration[5.0]
  def change
    add_column :question_masters, :correct, :boolean
  end
end
