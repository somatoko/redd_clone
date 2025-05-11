class SubmissionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.submission_mailer.new_response.subject
  #
  def new_response
    @comment = params[:comment]
    @submission = params[:submission]

    mail to: @submission.user.email, subject: "New response on #{@submission.title} via RedD"
  end
end
