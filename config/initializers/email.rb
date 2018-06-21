# frozen_string_literal: true

# Gmail?
#   https://security.google.com/settings/security/apppasswords
#   https://stackoverflow.com/questions/12884711/how-to-send-email-via-smtp-with-rubys-mail-gem

Mail.defaults do
  delivery_method :smtp,
                  port: 587,
                  address: 'smtp.' + ENV.fetch('SMTP_USER').split('@').last,
                  domain: ENV.fetch('SMTP_USER').split('@').last,
                  user_name: ENV.fetch('SMTP_USER'),
                  password: ENV.fetch('SMTP_PASSWORD'),
                  authentication: 'plain',
                  enable_starttls_auto: true
end
