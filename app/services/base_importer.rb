class BaseImporter
  ImportError = Class.new(RuntimeError)

  DATE_FORMATS = [
    # matcher, parser argument
    [/^(\d{1,2}\.){2}\d{2}$/, '%d.%m.%y']
  ].freeze

  def initialize(date_formats: DATE_FORMATS)
    @date_formats = date_formats
  end

  def import_batch(collection)
    ActiveRecord::Base.transaction do
      collection.each_with_index do |row, index|
        begin
          import(row)
        rescue Exception => error
          message = ['Line', index + 2, ':', error.message].join(' ')
          raise ImportError, message
        end
      end
    end
  end

  def import(*_args)
    raise 'not implemented'
  end

  private

  def parse_time(time)
    return time if time.is_a?(Time)
    Time.parse(time).utc
  end

  def parse_date(date)
    return date if date.is_a?(Date)

    if date.to_s == ''
      return nil
    end

    @date_formats.each do |format|
      if date =~ format.first
        return Date.strptime(date, format.last)
      end
    end

    Date.parse(date)
  end
end
