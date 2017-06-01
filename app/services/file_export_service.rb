class FileExportService
  FileExistsError = Class.new(StandardError)

  def initialize(string)
    @csv = string.dup.freeze
  end

  def to_file(path)
    raise FileExistsError, "File #{path} already exists" if File.exist?(path)

    FileUtils.mkdir_p(File.dirname(path))
    File.open(path, 'a') { |f| f.puts(to_s) }
  end

  def to_s
    @csv
  end
end
