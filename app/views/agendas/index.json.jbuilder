json.array!(@agendas) do |agenda|
  json.extract! agenda, :id, :title, :description
  json.start agenda.start_time
  json.end agenda.end_time
  json.url agenda_url(agenda, format: :html)
end
