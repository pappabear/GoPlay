class User < ActiveRecord::Base


  # --- accessors --------------------------------

  attr_accessor :remember_token, :activation_token, :reset_token


  # --- filters --------------------------------

  before_save :downcase_email

  before_create :create_activation_digest



  # --- validations --------------------------------

  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  validates :basic_notifications_email,
            format: {with: VALID_EMAIL_REGEX, message: "%{value} is not in a valid format"},
            allow_blank: true

  validates :urgent_notifications_email,
            format: {with: VALID_EMAIL_REGEX, message: "%{value} is not in a valid format"},
            allow_blank: true

  VALID_PHONE_NUMBER_REGEX = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/

  validates :basic_notifications_phone_number,
            format: {with: VALID_PHONE_NUMBER_REGEX, message: "%{value} is not in a valid format"},
            allow_blank: true

  validates :urgent_notifications_phone_number,
            format: {with: VALID_PHONE_NUMBER_REGEX, message: "%{value} is not in a valid format"},
            allow_blank: true

  has_secure_password

  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  validate :notifications_preferences



  after_validation :geocode_the_address, :on => [:create, :update]



  # --- public methods --------------------------------

  def geocode_the_address

    if self.zip.nil?
      return
    end

    begin
      address = GeocodedAddress.new(self.zip.downcase.tr(" ", "+"))
    rescue Exception => e
      errors.add(:zip, "address is not geocodeable. We can't determine the latitude and longitude. Please enter a valid address. #{e.message}")
      return
    end

    self.zip = address.formatted_address
    self.latitude = address.latitude
    self.longitude = address.longitude

  end


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end


  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end


  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end


  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end


  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end


  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end


  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end


  def notifications_preferences

    if self.basic_notifications_mode == 'none'
      #return
    elsif self.basic_notifications_mode == 'email'
      errors.add(:basic_notifications_email, "cannot be blank if you want email") if self.basic_notifications_email == ""
      #return
    elsif self.basic_notifications_mode == 'text'
      errors.add(:basic_notifications_text, "cannot be blank if you want a text") if self.basic_notifications_phone_number == ""
      #return
    end

    if self.urgent_notifications_mode == 'none'
      #return
    elsif self.urgent_notifications_mode == 'email'
      errors.add(:urgent_notifications_email, "cannot be blank if you want email") if self.urgent_notifications_email == ""
      #return
    elsif self.urgent_notifications_mode == 'text'
      errors.add(:urgent_notifications_text, "cannot be blank if you want a text") if self.urgent_notifications_phone_number == ""
      #return
    end


  end



  # --- private methods --------------------------------


  private


  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end


  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end


end
