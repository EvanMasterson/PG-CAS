# README
Hosted on - x

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
  sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
  sudo service postgresql initdb
  sudo service postgresql start
  sudo -u postgres createuser -s ec2-user
  sudo -u postgres createdb ec2-user
  sudo su postgres
  psql
  ALTER USER "ec2-user" WITH SUPERUSER;
  \q
  ```

  * Setup Configuration (Local)
  ```
  # Install PostgreSQL and initial DB creation
  brew install postgresql
  brew services start postgresql
  psql -d postgres
  CREATE DATABASE pg_cas_development;
  \q
  ```

* Deployment instructions
  ```
  
  ```

* Run instructions
  ```
  Local: rails s -b 0.0.0.0 (Runs on port 3000)
  AWS: rails s -e production -b 0.0.0.0 -p 80 (Runs on port 80)
  ```
