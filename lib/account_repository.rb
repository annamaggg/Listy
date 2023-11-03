require_relative 'account'
require_relative 'database_connection'

class AccountRepository
  def all_accounts
    sql = "SELECT id, username, passkey FROM accounts"
    results = DatabaseConnection.exec_params(sql, [])

    all_accounts = []
    results.each do |data|
      account = Account.new
      account.id = data['id']
      account.username = data['username']
      account.passkey = data['passkey']
      all_accounts << account
    end

    return all_accounts
  end

  def all_usernames 
    sql = 'SELECT * FROM accounts;'
    results = DatabaseConnection.exec_params(sql, [])

    usernames = []
    results.each do |item|
      usernames << item['username']
    end

    return usernames
  end

  def create(account)
    sql = 'INSERT INTO accounts (username, passkey) VALUES ($1, $2)'
    result = DatabaseConnection.exec_params(sql, [account.username, account.passkey])
    return result
  end

  def find_by_username(username)
    sql = 'SELECT id, username, passkey FROM accounts WHERE username = $1;'
      params = [username]
      result = DatabaseConnection.exec_params(sql, params).first

      account = Account.new
      account.id = result['id'].to_i
      account.username = result['username']
      account.passkey = result['passkey']
      
      return account
  end
end