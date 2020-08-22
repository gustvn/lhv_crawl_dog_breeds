# frozen_string_literal: true

require 'json'
require 'parallel'
require 'time'

puts "dog breeds: #{ARGV}"

if ARGV.size.zero?
  puts 'Please provide dog breeds to crawl'
  puts 'Usage: bundle exec ruby crawl_dog_breeds.rb [breed 1] [breed 2] ...'
  exit 1
end

updated_at_file = 'results/updated_at.json'
`echo '' >> #{updated_at_file}`

Parallel.each(ARGV, in_threads: 5) do |breed|
  breed_response = JSON.parse(`curl -XGET https://dog.ceo/api/breed/#{breed}/images`)
  status = breed_response['status']

  if status == 'error'
    json_string = "{ \"breed\": \"#{breed}\", " \
                    "\"timestamp\": \"#{Time.now}\", " \
                    "\"result\": \"#{breed_response['message']}\" }"
  else
    breed_file = "results/#{breed}.csv"

    `echo "name, image_link" > #{breed_file}`

    image_links = breed_response['message']
    image_links.each do |image_link|
      tokens = image_link.split('/')
      `echo "#{tokens[-2]}, #{image_link}" >> #{breed_file}`
    end

    json_string = "{ \"breed\": \"#{breed}\", " \
                    "\"timestamp\": \"#{Time.now}\", " \
                    "\"result\": \"#{breed_file}\" }"
  end

  `echo '#{json_string}' >> #{updated_at_file}`
end
