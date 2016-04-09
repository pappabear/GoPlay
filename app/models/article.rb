class Article < ActiveRecord::Base


  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :owner_id

  before_validation :convert_published_at_date, :on => [:create, :update]
  before_validation :convert_expired_at_date, :on => [:create, :update]


  private


  def convert_published_at_date

    if self.published_at_before_type_cast == ""
      return
    end

    if self.published_at.nil?
      return
    end

    if self.published_at_before_type_cast.split('-').size == 3
      # date is already in yyyy-mm-dd format
      return
    end

    parts = self.published_at_before_type_cast.split('/')
    self.published_at = parts[2] + '-' + parts[0] + '-' + parts[1]
  end


  def convert_expired_at_date
    if self.expired_at_before_type_cast == ""
      return
    end

    if self.expired_at.nil?
      return
    end

    if self.expired_at_before_type_cast.split('-').size == 3
      # date is already in yyyy-mm-dd format
      return
    end

    parts = self.expired_at_before_type_cast.split('/')
    self.expired_at = parts[2] + '-' + parts[0] + '-' + parts[1]
  end


end
