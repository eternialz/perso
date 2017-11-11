class Article
    include Mongoid::Document
    include Mongoid::Timestamps

    field :title, type: String
    field :content, type: String
    field :description, type: String

    validates :title, presence: true
    validates :content, presence: true
    validates :description, presence: true
end
