class DatePath
  def initialize(prefix: '', suffix: '', time: Time.now)
    @prefix = prefix
    @suffix = suffix
    @time = time
  end

  def to_s
    time_string = @time.strftime('%Y-%m-%d_%H-%M-%S')
    [@prefix, time_string, @suffix].join('')
  end
end
