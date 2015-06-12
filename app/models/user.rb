class User <ActiveRecord::Base
  include Slugable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true,  uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 6}

  slugable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6))
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twilio
    # put your own credentials here 
    account_sid = 'AC52df0a5985398362b550cb73c1dad298' 
    auth_token = '609c94b3a3630d7232d21cf2bb3ccf19' 
     
    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 
    msg = "Here's your login PIN for TimPosts: #{self.pin} :-)"
    client.account.messages.create({
      :from => '+18663586733', 
      :to => self.phone, 
      :body => msg,  
    })
  end

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end
  
end