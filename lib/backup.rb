# frozen_string_literal: true

class Backup
  attr_reader :files

  def initialize(files: [])
    @files = Array(files)
  end

  def perform(strategy:)
    strategy.perform(self)
  end
end
