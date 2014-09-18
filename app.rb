require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
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
  erb :visit
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]
	@title = "Yoooppy!"
	@message = "Dear #{@username}, thank you very much for choosing us!"

	Client.create(
		name: @username, 
		phone: @phone, 
		datestamp: @datetime, 
		barber: @barber, 
		color: @color
		)	

	erb :message
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
