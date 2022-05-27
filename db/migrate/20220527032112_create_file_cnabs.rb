class CreateFileCnabs < ActiveRecord::Migration[7.0]
  def change
    create_table :file_cnabs do |t|
      t.string :title
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
