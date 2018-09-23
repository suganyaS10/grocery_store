Application Set Up in Local

Clone this repository

git clone 'https://github.com/suganyaS10/grocery_store.git'

cd to the project directory and run bundle install

This application uses mysql as Database.

check the database configuration in config/database.yml and modify it accordingly

Then run rake db:create rake db:migrate rake seed:inventories (To seed initial data. this loads an admin user and few Inventories)

run

rails s

open the application in browser

Log in using

Admin User
Email: 12345@example.com password: 12345678

Shopper
Email: 123456@example.com password: 12345678


You can also Register yourself or Login