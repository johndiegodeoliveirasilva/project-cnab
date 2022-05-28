class ChangeColumnHourToImportFiles < ActiveRecord::Migration[7.0]
  def change
    change_column :import_files, :hour, :text
  end
end
