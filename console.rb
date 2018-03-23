require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({
  'name' => 'Simon',
  'funds' => 100
})
customer2 = Customer.new({
  'name' => 'Aileen',
  'funds' => 50
})
customer3 = Customer.new({
  'name' => 'Hugh Jackman',
  'funds' => 20
})

film1 = Film.new({
  'title' => 'Texas Chainsaw Massacre',
  'price' => 10
})
film2 = Film.new({
  'title' => 'Babe',
  'price' => 10
})
film3 = Film.new({
  'title' => 'Jaws',
  'price' => 10
})

customer1.save
customer2.save
customer3.save
film1.save
film2.save
film3.save

ticket1 = Ticket.new({'customer_id'=> customer1.id,'film_id'=> film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id'=> customer3.id,'film_id'=> film3.id})
ticket2.save
ticket2.update

customer2.delete
film2.delete

customer1.name = 'Shia'
customer1.update

p Customer.all
p Ticket.all
p customer1.find_films
p film1.find_customers
