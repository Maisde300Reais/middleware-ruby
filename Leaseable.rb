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
    puts "Renewing lease for: " + self.inspect
    @start_time = Time.now
    @renewals = @renewals + 1
  end

  #retorna :delete caso deseje apagar, :renew para renovar | default: delete
  def lease_expired
    puts "Deleting " + self.inspect
    return :delete
  end
end
