require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')
require_relative('./models/screening')

Customer.delete_all
Film.delete_all
Ticket.delete_all
Screening.delete_all

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

screening1 = Screening.new({
    'film_time' => '19:30'
  })
screening2 = Screening.new({
    'film_time' => '12:30'
  })
screening3 = Screening.new({
    'film_time' => '19:30'
  })


customer1.save
customer2.save
customer3.save

film1.save
film2.save
film3.save

screening1.save
screening2.save
screening3.save

ticket1 = Ticket.new({'customer_id'=> customer1.id,'film_id'=> film1.id, 'screening_id' => screening1.id})
ticket2 = Ticket.new({'customer_id'=> customer3.id,'film_id'=> film3.id, 'screening_id' => screening2.id})
ticket3 = Ticket.new({'customer_id'=> customer1.id,'film_id'=> film1.id, 'screening_id' => screening1.id})
ticket4 = Ticket.new({'customer_id'=> customer1.id,'film_id'=> film2.id, 'screening_id' => screening3.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save

customer1.buy_ticket(customer1, film2)
customer1.update

p Screening.all_plus_film
p customer1.find_films
p film1.find_customers
p customer1.find_number_of_tickets
p film1.find_number_of_customers
