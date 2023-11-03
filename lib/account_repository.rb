require_relative 'account'
require_relative 'database_connection'

class AccountRepository
  def all_accounts()
    sql = "SELECT id, username, passkey FROM accounts"
    results = DatabaseConnection.exec_params(sql, [])

    all_accounts = []
    results.each do |data|
      account = Account.new
      account.id = data['id']
      account.username = data['username']
      account.passkey = data['passkey']
      accounts << account
    end

    return all_accounts
  end
end