json.extract! car, :id, :company, :model, :year, :engine_type, :car_type, :seats, :distance_driven, :transmission_type, :car_description, :registered_number, :created_at, :updated_at
json.url car_url(car, format: :json)
