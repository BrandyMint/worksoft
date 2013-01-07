class Developer::BundlesController < Developer::BaseController
  before_filter :app

  def new
    @bundle ||= Bundle.new :version => app.next_version
  end

  private

  def app
    @app ||= developer_profile.apps.find params[:app_id]
  end
end
