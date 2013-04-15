class Developer::DashboardController < Developer::BaseController
  def show_headers

  end

  def show
    redirect_to developer_apps_path
  end
end
