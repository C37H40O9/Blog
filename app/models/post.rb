class Post < ActiveRecord::Base
  acts_as_taggable

  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                       length: {minimum: 5}

  has_attached_file :photo, :styles => {:medium => "500x500>", :thumb => "200x200>"}, :default_url => "/images/:style/missing.png"
  validates_attachment :photo,
                       :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

end
