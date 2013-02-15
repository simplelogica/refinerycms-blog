Refinery::Blog.configure do |config|

  Rails.application.config.rakismet.key = "akismetkey" # Your akismet key

  Rails.application.config.rakismet.url = 'http://yourdomain.com/' # Your domain

end
