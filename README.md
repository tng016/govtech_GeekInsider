# GovTech GeekInsider Assessment

The coding assessment as part of GovTech's TAP first stage interview process

## Getting Started - Option A: Cloud 9 IDE

### Installing

#### 1) Go to [C9.io](https://c9.io/), Sign Up/Sign in

#### 2) Crete a new workspace. Clone from Git using the following link
```
https://github.com/tng016/govtech_GeekInsider.git
```

#### 3) Install Ruby on your virtual IDE
```
$ rvm install ruby-2.3.7
```
or just follow the instructions on the terminal

#### 3) Install Gems
```
$ gem install bundler
$ bundle install
```

#### 4) Restart MySQL Database
```
$ mysql-ctl start
```
if you would like to use MySQL interactive shell
```
$ mysql-ctl cli
```

#### 5) Create MySQL Databases
```
$ rails db:create
```

#### 6) Migrate schema onto databases + seed the database
```
$ rails db:reset
```

#### 7) Click on Run Project at the top of the IDE
its green and it has an right arrow

#### 8) Open your application page
```
Your code is running at https://[your repo name]-[your username].c9users.io.
```
click on that link above

#### 9) Test it out by typing in https://[your repo name]-[your username].c9users.io/api/students
you should see a JSON with details of students I've seeded

#### [BONUS] Your project is now online!
Use [Postman](https://www.getpostman.com/) to interact with the API

## Getting Started - Option B: Local Deployment

### Prerequisites

Here are some of the software specifications to this project:

**Ruby**

Click [here](https://rubyinstaller.org/downloads/) to download if needed
```
$ ruby -v
ruby 2.3.7p456
```

**MySQL**

Log into MySQL terminal
```
mysql> SELECT VERSION();
+-----------+
| VERSION() |
+-----------+
| 8.0.15    |
+-----------+
```
Click [here](https://www.mysql.com/downloads/) to download if needed

**A good code editor of your choice**

Mine is [Atom](https://atom.io/)

### Installing

How to get a development env running

#### 1) Clone GitHub repo
```
$ git clone https://github.com/tng016/govtech_GeekInsider.git
```

#### 2) Install Gems
```
$ gem install bundler
$ bundle install
```

#### 3) Store your MySQL root password as a env variable
```
$ export MYSQL_PASSWORD='password'
```

#### 4) Create MySQL databases
```
$ rails db:create
```

#### 5) Migrate schema onto databases + seed the database
```
$ rails db:reset
```

#### 6) Start your rails local server
```
$ rails s
```

#### 7) Open your internet browser to [http://localhost:3000/api/students/](http://localhost:3000/api/students/)
You should see a JSON of students
```
[{"id":1,"email":"studentjon@example.com","is_suspended":false,"created_at":"2019-02-13T18:09:09.000Z","updated_at":"2019-02-13T18:09:09.000Z"},
{"id":2,"email":"studenthon@example.com","is_suspended":false,"created_at":"2019-02-13T18:09:09.000Z","updated_at":"2019-02-13T18:09:09.000Z"},
{"id":3,"email":"commonstudent1@example.com","is_suspended":false,"created_at":"2019-02-13T18:09:09.000Z","updated_at":"2019-02-13T18:09:09.000Z"},
{"id":4,"email":"commonstudent2@example.com","is_suspended":false,"created_at":"2019-02-13T18:09:09.000Z","updated_at":"2019-02-13T18:09:09.000Z"},
{"id":5,"email":"studentmary@example.com","is_suspended":true,"created_at":"2019-02-13T18:09:09.000Z","updated_at":"2019-02-13T18:32:16.000Z"},
{"id":6,"email":"studentbob@example.com","is_suspended":false,"created_at":"2019-02-13T18:09:09.000Z","updated_at":"2019-02-13T18:09:09.000Z"},
{"id":7,"email":"studentagnes@example.com","is_suspended":false,"created_at":"2019-02-13T18:09:09.000Z","updated_at":"2019-02-13T18:09:09.000Z"},
{"id":8,"email":"studentmiche@example.com","is_suspended":false,"created_at":"2019-02-13T18:09:09.000Z","updated_at":"2019-02-13T18:09:09.000Z"}]
```

## Running the tests

We will be using **RSPEC** for our tests.
Test files are located at **./spec**

To run the tests
```
$ rspec
```

## Design rationale

We are to design a school system that has students and teachers, and implement 4 APIs for the teachers' use.

#### Students and Teachers

I first implemented simple CRUD methods on both the student and teacher classes. This was because the 4 APIs to design worked on existing students and teachers and it is only reasonable that there should be an existing portal to manage CRUD on these classes

#### Associations

I used the has_and_belongs_to_many association to associate the Teacher and Student classes. This was because there was no requirement to have any attributes attributed to this registration association. However, on hindsight, I probably should have used has_many_through which will allow me extensibility should I need to give attributes to this registration

#### Suspension

I used a boolean attribute under student to denote a suspension. This is principally because the suspension is an attribute of a student and not the association between student and teacher. Chose not to delete instance as it would be easier to un-suspend him later on


## Possible Bugs

```
/Library/Ruby/Gems/2.3.0/gems/bootsnap-1.4.0/lib/bootsnap/load_path_cache/
core_ext/kernel_require.rb:21:in `require': dlopen(/Library/Ruby/Gems/2.3.0/
gems/mysql2-0.5.2/lib/mysql2/mysql2.bundle, 0x0009): dependent dylib
'libssl.1.0.0.dylib' not found for '/Library/Ruby/Gems/2.3.0/gems/mysql2-0.5.2/
lib/mysql2/mysql2.bundle' - /Library/Ruby/Gems/2.3.0/gems/mysql2-0.5.2/lib/
mysql2/mysql2.bundle (LoadError)
```

Check out [this stackoverflow page](https://stackoverflow.com/questions/51264240/rake-dbmigrate-error-with-mysql2-gem-library-not-loaded-libssl-1-0-0-dylib)

## Authors

**Ng Tze Yang**
