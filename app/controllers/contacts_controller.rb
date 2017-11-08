class ContactsController < ActionController::Base
    def create
        @contact = Contact.new(contact_params)
        discord_notify()
    end

    private
    def contact_params
        params.require(:contact).permit(:full_name, :mail, :message)
    end

    def discord_notify
        @url = ENV['DISCORD_WEBHOOK_URL']

        message = @contact.generate

        message.each do |m|
            send_message(m)
        end
    end

    def send_message(message)
        Retryable.retryable(tries: 5, sleep: 30, on: HTTParty::Error) do # Retry to use webhook 5 times each 30 seconds
            @result = HTTParty.post(
                @url,
                :body => {
                    :username => @contact.full_name,
                    :content => message
                }.to_json,
                :headers => { 'Content-Type' => 'application/json' }
            )
        end
    end
end
