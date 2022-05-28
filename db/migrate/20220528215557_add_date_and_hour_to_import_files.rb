class AddDateAndHourToImportFiles < ActiveRecord::Migration[7.0]
  def change
    add_column :import_files, :data, :date
    add_column :import_files, :hour, :time
  end
end
