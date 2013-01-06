class Developer::BaseController < ApplicationController
  before_filter :authenticate!
end
