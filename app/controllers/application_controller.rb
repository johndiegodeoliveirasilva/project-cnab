class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  include Pagy::Backend
end
