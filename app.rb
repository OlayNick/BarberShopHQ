require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
	@c = Client.new
  	erb :visit
end

post '/visit' do

	@c = Client.new params[:client]
	if @c.save
		erb "<h2>Спасибо, вы записались</h2>"
	else
		@error = @c.errors.full_messages.first	
		return erb :visit
		#{}"<h2>Ошибка</h2>"
	end
	# @username = params[:username]
	# @phone = params[:phone]
	# @datetime = params[:datetime]
	# @barber = params[:barber]
	# @color = params[:color]
	#@title = "Yoooppy!"
	#@message = "Dear #{@username}, thank you very much for choosing us!"

	# c = Client.new
	# c.name = @username
	# c.phone = @phone
	# c.datestamp = @datetime
	# c.barber = @barber
	# c.color = @color

	# c.save

	# Client.create(
	# 	name: @username, 
	# 	phone: @phone, 
	# 	datestamp: @datetime, 
	# 	barber: @barber, 
	# 	color: @color
	# 	)	

	#erb :message
end

get '/contacts' do
  	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@content = params[:content]
	@title = "Уииии!"
	@message = "Спасибо, что написали нам! Мы с Вами обязательно свяжемся."

	Contact.create(email: @email, content: @content)

	erb :message

end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
  	erb :barber
end

get '/bookings' do
	@clients = Client.order('created_at DESC')
 	erb :bookings
end

get '/client/:id' do
	@client = Client.find(params[:id])
  	erb :client
end
