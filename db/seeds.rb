# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

league = League.create(name: 'TF2fpg')
season = league.season.create(name: 'TF2fpg1')

frag = season.teams.create(name: 'Frag', tag: '`fp-')
ruth = season.teams.create(name: 'Ruthless', tag: 'R7')

frag.members.create(alias: 'cr4sh')
frag.members.create(alias: 'coco')
frag.members.create(alias: 'ricr')

ruth.members.create(alias: 'jesus')
ruth.members.create(alias: 'jesus')
ruth.members.create(alias: 'jesus')
