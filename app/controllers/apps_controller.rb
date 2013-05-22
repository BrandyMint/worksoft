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
    @kind_id = kind.present? ? kind.id : nil
    @query = AppSearchQuery.new params[:app_search_query]
    if params[:configuration_id].present?
      @bundles = matched_bundles.by_configuration_id( params[:configuration_id] )
    else
      @bundles = BundleFilter.new(current_system).perform matched_bundles
    end
  end

  def search
    @kind_id = kind.present? ? kind.id : nil
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
    if params[:kind_id].present?
      @kind = Kind.find(params[:kind_id])
    elsif params[:app_search_query][:kind_id].present?
      @kind = Kind.find(params[:app_search_query][:kind_id])
    else
      @kind = nil
    end
  end

end
