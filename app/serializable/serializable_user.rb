# frozen_string_literal: true

class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'

  attributes :name, :username, :email

  link :self do
    @url_helpers.api_v1_user_url(@object.id)
  end

end
