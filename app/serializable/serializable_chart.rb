# frozen_string_literal: true

class SerializableChart< JSONAPI::Serializable::Resource # :nodoc:
  type 'charts'

  attributes :name, :description, :workspace_id
end
