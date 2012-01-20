# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
j = Team.create(name: 'Jews', tag: 'j')
c = Team.create(name: 'Catholics', tag: 'c')

j.members.create(alias: 'moses')
j.members.create(alias: 'hollywood')
j.members.create(alias: 'money')

c.members.create(alias: 'jesus')
c.members.create(alias: 'usa')
c.members.create(alias: 'pope')
