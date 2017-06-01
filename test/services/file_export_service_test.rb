require 'test_helper'

class FileExportServiceTest < ActiveSupport::TestCase
  subject { FileExportService.new('content') }
  let(:file) { '/tmp/file.txt' }

  describe '#to_s' do
    it 'returns the string version of the given content' do
      assert_equal 'content', subject.to_s
    end
  end

  describe '#to_file' do
    before do
      FileUtils.rm_rf(file)
    end

    it 'exports content to file' do
      subject.to_file(file)

      assert File.exist?(file)
      assert_equal "content\n", File.read(file)
    end

    it 'raises an exception when file already exists' do
      subject.to_file(file)

      assert_raise(StandardError) do
        subject.to_file(file)
      end
    end

    it 'creates dir when they do not exist' do
      file = Rails.root.join('tmp', 'tests', 'dir1', 'dir2', 'file.csv')
      folder = Rails.root.join('tmp', 'tests')

      FileUtils.rm_rf(folder)
      refute File.exist?(folder)
      refute File.exist?(file)

      puts subject.to_file(file)

      assert File.exist?(folder)
      assert File.exist?(file)
      assert_equal "content\n", File.read(file)
    end
  end
end
