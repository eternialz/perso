class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    # before_action :set_locale
    layout 'application'

    def home
        @contact ||= Contact.new()

        @articles = Article.order_by(created_at: :desc).limit(2)

        respond_to do |format|
            format.html { render '/home', layout: 'home' }
        end
    end

    private
    def title(page_title)
        if page_title.to_s != ""
            @title = page_title.to_s + ' - ' + helpers.site_name
        end
    end

    # def set_locale
    #    I18n.locale = :fr # We only serve french content, so we enforce the :fr locale
    # end
end
