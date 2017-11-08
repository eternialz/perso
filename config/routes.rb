Rails.application.routes.draw do
    root 'application#home'

    post '/contact', to: 'contacts#create', as: "submit_contact_form"
end
