class AppsController < ApplicationController
  def index
     @apps = App.ready
  end

  def show
    @app = App.find params[:id]
  end

  def search
    params.delete_if {|key, value| value.empty? }

    if search_query?
      @search = Sunspot.search(App) do
        fulltext params[:query], :highlight => true if params[:query].present?

        with :kind_id, params[:kind_id] if params[:kind_id].present?
        #with :state, 'ready'
        paginate :page => params[:page], :per_page => 15
      end
      apps = @search.results
    else
      apps = App.ready
    end
    
    # фильтруем результат по запрошенной версии
    if params[:kernel_version].present?
        @apps = []
        apps.each do |app|
          @apps << app if app.have_bundle_with_kernel_version? params[:kernel_version]
        end
    else
        @apps = apps
    end

  end

private
  def search_query?
    params[:query].present? || params[:kind_id].present?
  end

end
