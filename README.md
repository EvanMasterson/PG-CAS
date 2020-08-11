# README
Hosted on - https://ncicloud.live

* Ruby on Rails version
  ```
  Ruby 2.6.3
  Rails ~> 6.0.3
  
  # Gemfile
  bundle install
  ```

* Setup Configuration (AWS)

  PostgreSQL Full Setup: (https://github.com/snowplow/snowplow/wiki/Setting-up-PostgreSQL#ec2)

  ```
  # Install PostgreSQL and initial DB creation (https://github.com/snowplow/snowplow/wiki/Setting-up-PostgreSQL#ec2)
  sudo yum install postgresql96 postgresql96-server postgresql96-devel postgresql96-contrib postgresql96-docs
  sudo service postgresql96 initdb
  sudo service postgresql96 start
  sudo -u postgres createuser -s PG_CAS
  sudo -u postgres createdb pg_cas_production

  # Auto start postgresql on instance bootup
  sudo chkconfig postgresql96 on
  ```

* Setup Configuration (Local)
  ```
  # Install PostgreSQL and initial DB creation
  brew install postgresql
  brew services start postgresql
  createuser -s PG_CAS
  createdb pg_cas_development
  ```

* Deployment instructions
  ```
  
  ```

* Run instructions
  ```
  bundle install
  rake assets:precompile
  rake db:migrate

  Local: rails s (Runs on port 3000)
  AWS: rails s -e production -b 0.0.0.0 -d (Runs on port 3000, forward port 3000 traffic to port 80 via ALB)
  ```
