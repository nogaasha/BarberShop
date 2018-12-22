require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb :index
end

# спросим Имя, номер телефона и дату, когда придёт клиент.
post '/' do
   @user_name = params[:user_name]
   @phone = params[:phone]
   @date_time = params[:date_time]

   @title="Thank You"
   @message = "Dear #{@user_name}, we'll be waiting for you at #{@date_time} "
# запишем в файл то, что ввёл клиент
   f = File.open './public/user.txt','a'
   f.write "User: #{@user_name},Phone: #{@phone}, Date and time: #{@date_time} \n"
   f.close
   erb :message
end

# Добавить зону /admin где по паролю будет выдаваться список тех, кто записался (из users.txt)

# sinatra text file sso
get '/admin' do
  erb :admin
end


post '/admin' do
   @login = params[:login]
   @password = params[:password]

   # проверим логин и пароль, и пускаем внутрь или нет:
   if @login == 'admin' && @password == 'krdprog'
   @file = File.open("./users.txt","r")
   erb :watch_result
     # @file.close - должно быть, но тогда не работает. указал в erb
   else
      @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
      erb :admin
   end
end

get '/about' do
   erb :about
end

get '/visit' do
   erb :visit
end
