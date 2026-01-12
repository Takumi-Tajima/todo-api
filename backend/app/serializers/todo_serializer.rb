class TodoSerializer
  include JSONAPI::Serializer
  attributes :content, :completed
end
