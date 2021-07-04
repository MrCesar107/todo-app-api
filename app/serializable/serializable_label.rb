# frozen_string_literal: true

class SerializableLabel < JSONAPI::Serializable::Resource # :nodoc:
  type 'labels'

  attributes :name, :color, :user_id
end
