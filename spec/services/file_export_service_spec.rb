require 'rails_helper'

RSpec.describe FileExportService do
  subject { FileExportService.new('content') }
  let(:file) { '/tmp/file.txt' }

  describe '#to_s' do
    it 'returns the string version of the given content' do
      expect(subject.to_s).to eq('content')
    end
  end

  describe '#to_file' do
    before do
      FileUtils.rm_rf(file)
    end

    it 'exports content to file' do
      subject.to_file(file)

      expect(File.exist?(file)).to be true
      expect(File.read(file)).to eq("content\n")
    end

    it 'raises an exception when file already exists' do
      subject.to_file(file)

      expect do
        subject.to_file(file)
      end.to raise_error(StandardError)
    end

    it 'creates dir when they do not exist' do
      file = Rails.root.join('tmp', 'tests', 'dir1', 'dir2', 'file.csv')
      folder = Rails.root.join('tmp', 'tests')

      FileUtils.rm_rf(folder)
      refute File.exist?(folder)
      refute File.exist?(file)

      subject.to_file(file)

      expect(File.exist?(folder)).to be true
      expect(File.exist?(file)).to be true
      expect(File.read(file)).to eq("content\n")
    end
  end
end
