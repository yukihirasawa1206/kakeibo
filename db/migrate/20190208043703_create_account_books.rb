class CreateAccountBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :account_books do |t|
      t.string :amount

      t.timestamps
    end
  end
end
