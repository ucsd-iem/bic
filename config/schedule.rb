every 2.hours do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  command "cd /var/rails/bic2013/current && script/rails runner -e production 'Attendee.import' 2> /dev/null"
end