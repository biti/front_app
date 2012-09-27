class Notification < ActiveRecord::Base

  NEW = 0
  READ = 1
  STASHED = 2

  belongs_to :to, :class_name => 'Subscriber'
  attr_accessible :content, :type
  validates :to, :presence => true
  validates :content, :presence => true, :allow_blank => false
  validates :state, :inclusion => { :in => [ NEW, READ, STASHED ] }
  validates :marked_at, :presence => true

  def initialize(*rest)
    super
    self.state = NEW
    self.marked_at = Time.now
  end

  def read
    if self.state == NEW
      self.state = READ
      self.marked_at = Time.now
      self.save
    end
  end

  def stash
    if self.state != STASHED
      self.state = STASHED
      self.marked_at = Time.now
      self.save
    end
  end

end
