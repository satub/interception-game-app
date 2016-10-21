# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

integra = Player.create(email: 'integra@hellsing.org', password: 'ihatemyuncle', alias: 'Sir')
enrico = Player.create(email: 'enrico@iscariot.org', password: 'thenextpope', alias: 'Conquistador')
major = Player.create(email: 'major@millenium.org', password: 'ilovewar', alias: 'Deus Ex Machina')

game1 = Game.create(title: 'Purge', status: 'active', map_name: 'Asylum', map_size: 8, background_image_link: "http://vignette2.wikia.nocookie.net/hellsing/images/5/50/Hellsing-sign.jpg/revision/latest?cb=20090913020525")
game2 = Game.create(title: 'Battle of Millennia', status: 'pending', map_name: 'Skies Above London', map_size: 12, background_image_link: "http://vignette4.wikia.nocookie.net/hellsing/images/5/57/69--bloodmoon.jpg/revision/latest?cb=20100718234424")

GamePlayer.create(game_id: game1.id, player_id: integra.id, creator: false)
GamePlayer.create(game_id: game1.id, player_id: enrico.id, creator: true)
GamePlayer.create(game_id: game2.id, player_id: major.id, creator: true)

game1.update(turn: integra.id)
integra.update(current_game_id: game1.id)
enrico.update(current_game_id: game1.id)
major.update(current_game_id: game2.id)

4.times do
  Location.create(controlled_by: integra.id, game_id: game1.id, content: Faker::ChuckNorris.fact, defense: rand(50..200))
end
4.times do
  Location.create(controlled_by: enrico.id, game_id: game1.id, content: Faker::StarWars.quote, defense: rand(50..200))
end
12.times do
    Location.create(controlled_by: major.id, game_id: game2.id, content: Faker::StarWars.quote, defense: rand(50..200))
end

alu = Character.create(player_id: integra.id, name: 'Alucard', image_link: 'http://4.bp.blogspot.com/-USFVX_GxATQ/UP6Y7Z3dXNI/AAAAAAAAClk/KcXutQoUoUA/s1600/Alucard-Hellsing-Ultimate.jpg', personality: 'devil-may-care', role: 1)
seras = Character.create(player_id: integra.id, name: 'Draculina', image_link: 'http://vignette2.wikia.nocookie.net/deathbattlefanon/images/1/16/Seras_Victoria.jpg/revision/latest?cb=20150301023129', personality: 'fiercely loyal')
pip = Character.create(player_id: integra.id, name: 'Pip', image_link: 'http://vignette3.wikia.nocookie.net/hellsing/images/e/e7/Pipbust.jpg/revision/latest?cb=20160214011212', personality: 'french rogue')

andr = Character.create(player_id: enrico.id, name: 'Angeldust', image_link: 'http://66.media.tumblr.com/34fb9e2010433bd380329b47d08eae35/tumblr_nri8xpE8Bk1soy0x2o1_1280.jpg', personality: 'pathologically righteous', role: 1)
hei = Character.create(player_id: enrico.id, name: 'Wolfe', image_link: 'http://i63.photobucket.com/albums/h123/AquilineFury/Misc/heinkelwiki.jpg', personality: 'fiercely loyal')
yum = Character.create(player_id: enrico.id, name: 'Yumie', image_link: 'http://vignette2.wikia.nocookie.net/villains/images/6/6f/Yumie_Takagi.jpg/revision/latest?cb=20110818230940', personality: 'fiercely loyal')

hans = Character.create(player_id: major.id, name: 'Hans', image_link: 'http://orig07.deviantart.net/3bdd/f/2008/339/d/9/captain_hans_transforming_by_zorinblitzpsycho.jpg', personality: 'strong and violent type', role: 1)
cat = Character.create(player_id: major.id, name: 'Schrödinger', image_link: 'http://static3.comicvine.com/uploads/original/1/18154/902278-24__schrosmiling.jpg', personality: 'fickle')
zorin = Character.create(player_id: major.id, name: 'ZBlitz', image_link: 'http://static8.comicvine.com/uploads/original/1/18154/903059-15__zorinblitz.jpg', personality: 'impatient with hint of bloodlust')

GameCharacter.create(game_id: game1.id, character_id: alu.id, troops: 4000)
GameCharacter.create(game_id: game1.id, character_id: seras.id, troops: 2000)
GameCharacter.create(game_id: game1.id, character_id: andr.id, troops: 4000)
GameCharacter.create(game_id: game1.id, character_id: hei.id, troops: 2000)
GameCharacter.create(game_id: game2.id, character_id: hans.id, troops: 6000)
GameCharacter.create(game_id: game2.id, character_id: cat.id, troops: 3000)
