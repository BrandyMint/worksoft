module ApplicationHelper
  include BootstrapHelper

  def developer_profile
    current_user.developer_profile
  end
end
