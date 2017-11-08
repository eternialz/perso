class Contact
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :full_name, :mail, :message

    # Validations
    validates :full_name, :presence => true
    validates :mail, :presence => true
    validates_format_of :mail, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ #Verify the pattern of the mail field
    validates :message, :presence => true

    # Attributes values
    def initialize(attributes = {})
        attributes.each do |name, value|
            send("#{name}=", value)
        end
    end

    # Prevent linking to database
    def persisted?
        false
    end

    # Generate message content for sending
    def generate
        message = [
                "Contact from : " + self.full_name +
                "\nMail : " + self.mail +
                "\nMessage : \n" + self.message[0..1500]
        ]


        # Separate message by parts since discord only
        # accept message with 2000 characters or less.
        # Using 1500 to be sure sinc ethe message contain
        # the name, mail, and labels
        parts = self.message.length / 1500

        parts.times do |i|
            start = 1500 * (i + 1) # Skip first 1500 characters
            message << self.message[start..(start + 1500)] + "\n"
        end

        message # return message
    end
end
