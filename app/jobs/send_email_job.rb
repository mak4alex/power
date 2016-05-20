class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(help)
    HelpMailer.demand(help).deliver_later
  end
end
