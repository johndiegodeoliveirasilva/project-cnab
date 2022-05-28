class CreateKindTransaction < ActiveRecord::Migration[7.0]
  def change
    create_table :kind_transactions do |t|
      t.integer :kind
      t.string :description
      t.integer :nature
      t.text :signal

      t.timestamps
    end
  end
end
