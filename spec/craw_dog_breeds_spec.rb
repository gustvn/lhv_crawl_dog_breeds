require 'json'

describe "craw dog breeds data" do
  updated_at_file = "results/updated_at.json"

  it 'empty arguments' do
    system('bundle exec ruby crawl_dog_breeds.rb')
    expect($?.exitstatus).to eq(1)
  end

  it 'wrong argument' do
    system('bundle exec ruby crawl_dog_breeds.rb aaa')
    expect($?.exitstatus).to eq(0)

    result = JSON.parse(`tail -n 1 #{updated_at_file}`)['result']
    expect(result).to eq("Breed not found (master breed does not exist)")
  end

  it 'right argument' do
    breed = 'african'
    result_file = "results/#{breed}.csv"

    system("bundle exec ruby crawl_dog_breeds.rb #{breed}")
    expect($?.exitstatus).to eq(0)

    result = JSON.parse(`tail -n 1 #{updated_at_file}`)['result']
    expect(result).to eq(result_file)

    check_file = `ls #{result_file}`
    expect(check_file.strip).to eq(result_file)
  end
end