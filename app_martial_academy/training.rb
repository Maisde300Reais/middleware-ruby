class Training

	attr_accessor :id, :day, :time, :instructor

	def initialize(id, day, time, instructor)
		@id = id
		@day = day
		@time = time
		@instructor = instructor
	end

end