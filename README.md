# README

URL Shortener create shortened URLs for a given user. It records the number of times the shortened URL has been used and redirects the user
to the full URL.

It is currently a demo app.

It is a standard Rails application following the MVC pattern. 

* Database initialization
```
	$ rake db:create
	$ rake db:migrate
```

* App initialization
You can run the app like standard Rails app and visit http://localhost:3000
You will be greeted with a login/sign up screen
after login, you can click on Manage URLs
after which you can create shortened URLS
click on show to get redirected to the full URL
```
	$ rails server
```

* How to run the test suite
It relies on RSpec for testing
```
	$ rspec .
```

