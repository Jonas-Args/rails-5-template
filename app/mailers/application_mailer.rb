class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  private

  # def send_mail(email, subject, body)
  #   mail(to: email, subject: subject, body: body, content_type: "text/html")
  # end

  def domain
    ENV['DOMAIN'] || 'http://localhost:3000'
  end

end
