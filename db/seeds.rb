# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
kind = Kind.create(title: 'Отчет', ext: 'erf')
Kind.create(title: 'Обработка', ext: 'epf')
Kind.create(title: 'Обработка ТЧ (табличной части)', ext: 'epf')
Kind.create(title: 'Печатная форма', ext: 'epf')
App.all.each {|app| app.update_attribute(:kind, kind) unless app.kind}
