class CreateUploadEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :upload_emails do |t|
      t.references :customer, null: true, foreign_key: true
      t.string :status, default: 'queueding'

      t.timestamps
    end
  end
end
