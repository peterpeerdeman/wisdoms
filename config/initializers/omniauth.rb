OmniAuth.config.logger = Rails.logger
OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['WISDOMS_FB_APP_ID'],ENV['WISDOMS_FB_APP_SECRET'],:scope => 'email, publish_actions'
end
