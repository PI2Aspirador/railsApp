json.extract! agenda, :id, :title, :description, :start_time, :end_time, :created_at, :updated_at
json.url agenda_url(agenda, format: :json)