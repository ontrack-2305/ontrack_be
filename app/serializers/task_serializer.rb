class TaskSerializer
  include JSONAPI::Serializer
  attributes :name, :category, :mandatory, :event_date, :frequency, :time_needed, :user_id, :notes, :skipped, :image
end