# -*- coding: utf-8 -*-
class AppsController < ApplicationController

  before_filter :kind

  before_filter do
    @all_kindes = { nil => OpenStruct.new( :title => 'Все', :active => !kind ) }

    Kind.ordered.each do |k|
      @all_kindes[k.id] = OpenStruct.new :title => k.title, :active => k==kind
    end
  end

  def index
     @query = AppSearchQuery.new params[:app_search_query]
     @bundles = BundleFilter.new(current_system).perform matched_bundles
  end

  def search
    @query = AppSearchQuery.new params[:app_search_query]

    @bundles = matched_bundles

    if @query.valid?
      @bundles = @bundles.by_name @query.name
    else
      flash[:notice] = 'Неверный поисковый запрос'
    end

    @bundles = BundleFilter.new(current_system).perform @bundles

    render :index
  end

  def show
    @app = App.find params[:id]
  end

  private

  def matched_bundles
    Bundle.active.by_kind( kind )
  end

  def kind
    return @kind if defined? @kind
    @kind = params[:kind_id].present? ? Kind.find( params[:kind_id] ) : nil
  end

end
