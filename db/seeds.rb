# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
CSV.foreach('db/csv/places.csv', headers: true) do |row|
  Place.create(
    name:row['name'] ,
    tel:row['tel'] ,
    address:row['address'] ,
    url:row['url'] ,
    place_detail:row['place_detail'],
    area_id:row['area_id'],
    train_id:row['train_id'],
    user_id:row['user_id']
  )
end

CSV.foreach('db/csv/place_genres.csv', headers: true) do |row|
  Place.create(
    name:row['place_id'] ,
    tel:row['genre_id']
  )
end
