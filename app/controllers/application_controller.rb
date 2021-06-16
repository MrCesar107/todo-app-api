# frozen_string_literal: true

class ApplicationController < ActionController::API # :nodoc:
  def api_response(resource)    
    if resource.errors.empty?
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, status: 400
    end
  end
end
