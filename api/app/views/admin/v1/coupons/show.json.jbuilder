json.coupon do
  json.(@coupon, :code, :status, :due_date, :discount_value)
end
