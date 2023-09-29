class TaskSerializer
  include JSONAPI::Serializer
  attributes :name, :category, :mandatory, :event_date, :frequency, :user_id, :notes, :skipped, :image_url
end