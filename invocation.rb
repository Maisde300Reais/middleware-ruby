class Invocation < Hash
  def _dump level
    [@name, @version].join ':'
  end

  def self._load args
    new(*args.split(':'))
  end
end