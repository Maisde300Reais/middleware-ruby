class DefaultInvoker
  def invoke(invocation)
    mid = Middleware.instance
    lcm = Lifecycle_manager.instance

    puts invocation

    remote = mid.routes_to_objects[invocation[:url]][invocation[:http_action]]

    obj, method = remote.split("#")

    return mid.get_remote_object(obj).send(method, invocation[:params])
  end
end