json.array!(@vacancies) do |vacancy|
  json.extract! vacancy, :id, :name, :date_in, :date_up, :salary, :contacts, :skills
  json.url vacancy_url(vacancy, format: :json)
end
