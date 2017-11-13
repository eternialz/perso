class Article
    include Mongoid::Document
    include Mongoid::Timestamps

    field :title, type: String
    field :content, type: String
    field :description, type: String

    validates :title, presence: true
    validates :content, presence: true
    validates :description, presence: true

    def previous
        self.class.where(:created_at.gt => created_at).first
    end

    def next
        self.class.where(:created_at.lt => created_at).last
    end
end
