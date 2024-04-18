class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :orders
  has_many :order_items, through: :orders
  has_many :plants, through: :order_items
  
  belongs_to :province, optional: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name first_name last_name email phone city province_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[province]
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable, 
  #        :omniauthable, omniauth_providers: [:google_oauth2]

  devise :rememberable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    user = find_or_initialize_by(provider: access_token.provider, uid: access_token.uid)
    user.email = access_token.info.email
    user.name = access_token.info.name
    # user.password = Devise.friendly_token[0,20]
    user.save

    # data = access_token.info
    # puts "data: #{access_token}"
    # puts "info: #{access_token.info}"
    # puts "extra: #{access_token.extra}"
    # user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    # unless user
    #     user = User.create(
    #       name: data['name'],
    #       email: data['email'],
    #       password: Devise.friendly_token[0,20],
    #       provider: access_token.provider,
    #       uid: access_token.uid
    #     )
    # end
    user
  end
end


#By continuing, Google will share your name, email address, 
# language preference, and profile picture with Sprout Ecommerce. 
# add: name, 


# provider (required) - The provider with which the user authenticated (e.g. 'twitter' or 'facebook')
# uid (required) - An identifier unique to the given provider, such as a Twitter user ID. Should be stored as a string.
# info (required) - A hash containing information about the user
#     name (required) - The best display name known to the strategy. Usually a concatenation of first and last name, but may also be an arbitrary designator or nickname for some strategies
#     email - The e-mail of the authenticating user. Should be provided if at all possible (but some sites such as Twitter do not provide this information)
#     nickname - The username of an authenticating user (such as your @-name from Twitter or GitHub account name)
#     first_name
#     last_name
#     location - The general location of the user, usually a city and state.
#     description - A short description of the authenticating user.
#     image - A URL representing a profile image of the authenticating user. Where possible, should be specified to a square, roughly 50x50 pixel image.
#     phone - The telephone number of the authenticating user (no formatting is enforced).
#     urls - A hash containing key value pairs of an identifier for the website and its URL. For instance, an entry could be "Blog" => "http://intridea.com/blog"
# credentials - If the authenticating service provides some kind of access token or other credentials upon authentication, these are passed through here.
#     token - Supplied by OAuth and OAuth 2.0 providers, the access token.
#     secret - Supplied by OAuth providers, the access token secret.
#     expires - Boolean indicating whether the access token has an expiry date
#     expires_at - Timestamp of the expiry time. Facebook and Google Plus return this. Twitter, LinkedIn don't.
# extra - Contains extra information returned from the authentication provider. May be in provider-specific formats.
#     raw_info - A hash of all information gathered about a user in the format it was gathered. For example, for Twitter users this is a hash representing the JSON hash returned from the Twitter API.
