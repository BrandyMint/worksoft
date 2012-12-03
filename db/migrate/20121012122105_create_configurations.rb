# -*- coding: utf-8 -*-
class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :name, :null => false

      t.timestamps
    end

    Configuration.create :name => 'БухгалтерияПредприятия'
    Configuration.create :name => 'КомплекснаяАвтоматизация'
    Configuration.create :name => 'УправлениеТорговлей'
  end
end
