class CreateImportFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :import_files do |t|
      t.decimal :value
      t.string :cpf
      t.string :card
      t.references :kind_transaction, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
