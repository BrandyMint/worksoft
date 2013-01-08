class Developer::DashboardController < Developer::BaseController
  def show
    redirect_to developer_apps_path
  end
end
