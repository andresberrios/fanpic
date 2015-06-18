class ApplicationResponder < ActionController::Responder
  # Override the default API behavior
  def api_behavior
    raise MissingRenderer.new(format) unless has_renderer?

    if get?
      display resource
    elsif post?
      display resource, status: :created, location: api_location
    elsif put? || patch?
      display resource, status: :ok, location: api_location
    else
      head :no_content
    end
  end

  # Override JSON errors response
  def json_resource_errors
    resource.errors.messages.to_json
  end

  include Responders::HttpCacheResponder
end
