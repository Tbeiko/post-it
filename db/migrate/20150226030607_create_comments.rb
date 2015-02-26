class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
    end
  end
end
