class Invocation < Hash

  def initialize(method="", params={})
    self["method"]=method
    params.each do |key, value|
      self[key]= value
    end
  end

  def method=(method)
    self["method"] = method
  end

  def method
    self["method"]
  end

  def params
    result = self
    result.delete("method")
    result
  end

  def add_param(key, value)
    self[key] = value
  end

  def get_param(key)
    self[key]
  end
end
