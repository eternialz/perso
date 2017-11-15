class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_locale
    layout 'application'

    def home
        @contact ||= Contact.new()

        @articles = Article.order_by(created_at: :desc).limit(2)

        render '/home'
    end

    private
    def title(page_title)
        if page_title.to_s != ""
            @title = page_title.to_s + ' - ' + helpers.site_name
        end
    end

    def set_locale
        unless params[:locale].blank?
            session[:locale] = params[:locale]
        end

        I18n.locale = session[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
    end

    private
    def extract_locale_from_accept_language_header
        request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
end
