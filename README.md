## Installitation
This tutorial is about how to deploy this project on AWS cloud9. 

First install ruby2.4 or use ruby2.6, which is the default setting of AW cloud9.
`rvm install 2.4.0` or `rvm use 2.6.0`

Then install PG on AWS:
`sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs`

Third, fork and clone repo on your own AWS cloud9:
`git clone git@github.com:*****************/TAMUART_new.git`

Changing to the folder of TAMUART_new and type `bundle install`
#### Installitation of PG
Finally we need to do something so that we could use PG on AWS cloud9. Start the PG server:`sudo service postgresql initdb` 

Then change the setting in postgresql.conf, there are two lines we need to edit.
`sudo vim /var/lib/pgsql9/data/postgresql.conf`
uncomment 
```
#listen_addresses = 'localhost'
#port = 5432
```
to
```
listen_addresses = 'localhost'
listen_addresses = 'port = 5432
```

The next is pg_hba.conf, there are many parameters we need to edit, be careful.

`sudo vim /var/lib/pgsql9/data/pg_hba.conf`

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD
# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             ec2-user        127.0.0.1/0             trust
# IPv6 local connections:
host    all             all             ::1/128                 md5
```

The last step, we need to login as Postgres User and change Password / add ec2-user. Just paste the follow commands into the terminate.  
`sudo service postgresql restart`

`sudo su - postgres # login as postgres user`

`psql -U postgres # login to postgres db as postgres user`

Change Password

`ALTER USER postgres WITH PASSWORD 'YOUR_PASSWORD';`

Add ec2-user

`CREATE USER "ec2-user" SUPERUSER;`

`ALTER USER "ec2-user" WITH PASSWORD 'YOUR_PASSWORD';`

Exit postgres:

`postgres=# \q`

`exit`


## Getting started
When you complete all the installitation and editing above, we could start the APP.
To get started with the app, we need to prepare the dataset by following commonds

``` $ rails db:migrate:reset ```

`$ rails db:seed`

Start the APP
``` $ rails server ```
