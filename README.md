# Crawl Dog Breeds Data

## 1. Install RVM and Ruby Gems

### 1.1. Install RVM and Ruby 2.7.1:

```
$ sudo apt install curl
$ command curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg --import -
$ \curl -L https://get.rvm.io | sudo bash -s stable --ruby=2.7.1
```
Open **~/.bashrc**, then add this into the end of the file:

```
# Load RVM if it is installed
source /usr/local/rvm/scripts/rvm
```

### 1.2. Install dependency
```
$ sudo bash -lc 'gem install bundler'
$ sudo bash -lc 'bundler install'
```

## 2. Business requirement
Create a Ruby script that will:
- Expect an input parameter containing an array of dog breeds.
- In five parallel threads downloads the data for those breeds from DogAPI (https://dog.ceo/dog-api/documentation)
- The results will be saved to CSV files with a header line (each breed into {breed_name}.csv) and contain columns: breed name and link to the image
- Apart from those csv files the script will also create one file "updated_at.json" in JSON format that will contain a list of all the downloaded files and timestamp of when each of them was created
- The code should pass the Linter validation with default rubocop settings (https://github.com/rubocop-hq/rubocop)
- There should be a simple test using Rspec that will succeed on the code with testing/mocked data
- Put the code to a public repository on GitHub (https://github.com/) and provide us with a link to it.

## 3. Test and Run
### 3.1 Rspec test
```
$ bundle exec rspec
```
### 3.2 Run script
```
$ bundle exec ruby crawl_dog_breeds.rb [breed 1] [breed 2] ...
```
