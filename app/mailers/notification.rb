class Notification < ActionMailer::Base
  default from:  "Bioengineering Institute of California <bic@ucop.edu>"
  default subject: "14th UC Systemwide Bioengineering Symposium, June 19-21"
  default url: "http://bic.ucop.edu/2013"
  default content_type: "text/plain"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.confirmation.subject
  #
  #def confirmation
   # @greeting = "Hi"
  #  mail to: "to@example.org"
  #end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.update.subject
  #
  #def update
  #  @greeting = "Hi"
#    mail to: "to@example.org"
 # end
  
  def abstract_confirmation(abstract)
    @abstract = abstract
    
    mail(:to => abstract.attendee.email, :subject => "14th UC Systemwide Bioengineering Symposium, June 19-21 - We have received your abstract")
  end
  
  def abstract_update(abstract)
    @abstract = abstract

    mail(:to => abstract.attendee.email, :subject => "14th UC Systemwide Bioengineering Symposium, June 19-21 - We have received your abstract update")
  end
end
