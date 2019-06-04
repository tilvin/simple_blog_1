class ActiveStorage::DiskRepresentationController < ActiveStorage::DiskController

  include Authenticatable

  before_action :authenticate_by_token_and_user!

end
