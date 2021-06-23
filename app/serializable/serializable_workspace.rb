# frozen_string_literal: true

class SerializableWorkspace < JSONAPI::Serializable::Resource # :nodoc:
  type 'workspaces'

  attributes :name, :user_id
end
