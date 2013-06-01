module Leaseable
  attr_reader :renewals

  def start_lease(time_to_live)
    @start_time = Time.now
    @time_to_live = time_to_live
    @renewals = 0
  end

  def expired_lease?
    return Time.now - @start_time >= @time_to_live
  end

  def renew_lease
    @start_time = Time.now
    @renewals = @renewals + 1
  end

end
