json.coupons do
  json.array! @coupons, :code, :status, :due_date, :discount_value
end
