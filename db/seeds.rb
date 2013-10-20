# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(first_name:"Morgan", last_name:"Freeman", email:"freeman@heaven.com", password:"123456", username:"freeman")
User.create(first_name:"Chuck", last_name:"Norris", email:"norris@rhk.com", password:"123456", username:"norris")

50.times do 
  name = Faker::Name.first_name
  last = Faker::Name.last_name
  username = last
  email = Faker::Internet.email
  User.create(first_name: name, last_name: last, username: username, email: email, password:"123456")
end

#create random taxi

#regex for plate /\d?[ก-ฮ][ก-ฮ]\d{1,4}/
thaiAlpha = ('ก'..'ฮ').to_a
50.times do
  while true
    taxi = Taxi.new

    #generate random plate
    plate = ''
    if rand(2) == 1
      plate += (rand(9) + 1).to_s# 1-9
    end
    plate += thaiAlpha[rand(46)]
    plate += thaiAlpha[rand(46)]
    no_digit = rand(4) # 0-3

    begin
      plate += (rand(9)+1).to_s
      no_digit -= 1
    end while no_digit >= 0
    taxi.plate_no = plate
    if taxi.save
      break;
    end
  end
end

#create random rating for each taxi
taxis =Taxi.all
user_ids = User.all.pluck(:id)
taxis.each do |taxi|
  rand(50).times do
    taxi.rates.create(rating: rand(3)-1, user_id: user_ids.sample)
  end
end

# #create random lost and found item
# users = User.all
# taxis = Taxi.all
# users.each do |user|
#   puts "#{user.first_name}"
#   #random lost items
#   rand(4).times do
#     item = Item.new
#     item.location = Faker::Address.city
#     item.item_name = Faker::Name.suffix
#     item.taxi = taxis.sample
#     item.item_type = 0
#     item.when = rand(10.years).ago.to_datetime
#     item.description = Faker::Lorem.sentence(10)
#     item.loser = user 

#     item.save!
#   end

#   #random found items
#    rand(4).times do
#     item = Item.new
#     item.location = Faker::Address.city
#     item.item_name = Faker::Name.suffix
#     item.taxi = taxis.sample
#     item.item_type = 1
#     item.when = rand(10.years).ago.to_datetime
#     item.description = Faker::Lorem.sentence(10)

#     item.founder = user

#     item.save!
#   end
# end




