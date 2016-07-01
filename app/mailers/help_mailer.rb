class HelpMailer < ApplicationMailer

  def demand(help)
    @help = help
    attachments[help.attachment_file_name] =  File.read(help.attachment.path)
    mail from: help.email, to: ENV['EMAIL_RECIEVER'], subject: help.topic
  end

end
