# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

league = League.create(name: 'TF2fpg')
season = league.seasons.create(name: 'TF2fpg1')

frag = season.teams.create(name: 'Frag', tag: '`fp-')
ruth = season.teams.create(name: 'Ruthless', tag: 'R7')

frag.members.create(alias: 'cr4sh')
frag.members.create(alias: 'coco')
frag.members.create(alias: 'ricr')

ruth.members.create(alias: 'blade')
ruth.members.create(alias: 'idk')
ruth.members.create(alias: 'again')

Map.create([
{ name: 'cp_badlands' },
{ name: 'cp_granary' },
{ name: 'cp_gullywash' },
{ name: 'cp_gravelpit' },
{ name: 'cp_warmfront' },
{ name: 'cp_snakewater' },
{ name: 'cp_yukon_final' },
{ name: 'koth_pro_viaduct_rc3' },
{ name: 'cp_standin' },
{ name: 'ctf_turbine' }
])
