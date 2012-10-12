#Конфиг деплоя на staging
server 'icfdev.ru', :app, :web, :db, :primary => true
set :application, "stage.worksoft.ru"
set(:current_branch) { `git branch`.match(/\* (\S+)\s/m)[1] || raise("Couldn't determine current branch") }
set :branch, defer { current_branch } unless exists?(:branch)
set :rails_env, "development"

