require_relative '../extended_infraestructure/lifecycle_manager'

class DefaultInvoker
  def initialize
    @invocation_intercepters = []
  end

  def invoke(invocation)
    mid = Middleware.instance
    lcm = Lifecycle_manager.instance

    remote = mid.routes_to_objects[invocation[:url]][invocation[:http_action]]

    obj, method = remote.split("#")

    @invocation_intercepters.each do |inter|
      inter.instance.before_invocation(invocation)
    end

    result = lcm.get_remote_object(obj).send(method, invocation[:params])

    @invocation_intercepters.each do |inter|
      inter.instance.after_invocation(invocation)
    end

    return result
  end
end