require 'account_repository'
require 'database_connection'

def reset_tables 
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'listy-db' })
  connection.exec(seed_sql)
end

describe AccountRepository do 
  before(:each) do 
    reset_tables
  end

  it "returns all accounts" do
    repo = AccountRepository.new
    expect(repo.all_accounts.length).to eq(1)
    expect(repo.all_accounts.last.username).to eq('annamag')
  end

  it "returns all usernames" do
    repo = AccountRepository.new
    expect(repo.all_usernames.length).to eq(1)
    expect(repo.all_usernames.last).to eq('annamag')
  end
end