Rails.application.routes.draw do
    root 'application#home'

    post '/', to: 'contacts#create', as: "submit_contact_form"
end
