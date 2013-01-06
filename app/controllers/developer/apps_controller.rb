class Developer::AppsController < Developer::BaseController
  def new
    @app = App.new
  end

  def create
    
  end
end
