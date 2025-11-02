class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :cod_product
      t.string :subject_email

      t.timestamps
    end
  end
end
