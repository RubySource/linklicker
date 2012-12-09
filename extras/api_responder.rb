class ApiResponder < ActionController::Responder
  def display(resource, options={})
    options[:layout] = "basic"

    collection = resource.respond_to?(:to_ary) && resource.to_ary
    if collection 
      controller.render json: "[#{collection.map {|o| controller.render_to_string o, options}.join(',')}]"
    else
      controller.render resource, options
    end
  end
end
