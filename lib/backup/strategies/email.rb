# frozen_string_literal: true

class Backup
  module Strategies
    class Email
      def initialize(
        recipients:,
        from:,
        subject: 'Field Service Backup',
        body: 'Attached your backups'
      )
        @recipients = recipients
        @from = from
        @subject = subject
        @body = body
      end

      def deliver(backup)
        mail = Mail.new.tap do |m|
          m.from = @from
          m.to @recipients
          m.subject @subject
          m.body = @body

          backup.files.each do |file|
            m.add_file file
          end
        end

        mail.deliver
      end
    end
  end
end
