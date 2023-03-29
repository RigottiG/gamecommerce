# frozen_string_literal: true

class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :status
      t.decimal :discount_value, precision: 5, scale: 2
      t.datetime :due_date

      t.timestamps
    end
  end
end
