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

  Application deployed on EC2\
  PostgreSQL DB hosted on RDS\
  Redis configured with ElastiCache

  PostgreSQL Full Setup: (https://github.com/snowplow/snowplow/wiki/Setting-up-PostgreSQL#ec2)

  ```
  # Install PostgreSQL and initial DB creation
  sudo yum install postgresql96 postgresql96-server postgresql96-devel postgresql96-contrib postgresql96-docs
  sudo service postgresql96 initdb
  sudo service postgresql96 start
  sudo -u postgres createuser -s PG_CAS
  sudo -u postgres createdb pg_cas_production

  # Auto start postgresql on instance bootup
  sudo chkconfig postgresql96 on

  # sidekiq - (Modify and add sidekiq script to /etc/init.d/ https://gist.github.com/stefanosc/ce4d6a97a5edafee8735)

  sudo chmod a+x /etc/init.d/sidekiq
  sudo chkconfig sidekiq on
  sudo service sidekiq start
  ```

* Setup Configuration (Local - Mac)
  ```
  # Install PostgreSQL and initial DB creation
  brew install postgresql
  brew services start postgresql
  createuser -s PG_CAS
  createdb pg_cas_development

  # Install Redis
  brew install redis
  redis-server --daemonize yes
  redis-cli shutdown (To turn off)

  # sidekiq
  sidekiq -q default
  ```

* Run instructions
  ```
  Common:
  bundle install
  rake assets:precompile
  rake webpacker:compile
  rake db:migrate

  Local (Mac): 
  rails s (Runs on port 3000)

  AWS: 
  rails s -e production -b 0.0.0.0 -d (Runs on port 3000)
  If using an ALB with SSL, forward port 443 traffic to your target group that routes traffic to EC2 instance
  ```
