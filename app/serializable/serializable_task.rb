# frozen_string_literal: true

class SerializableTask < JSONAPI::Serializable::Resource # :nodoc:
  type 'tasks'

  attributes :name, :description, :chart_id
end
