class StaticPagesController < ApplicationController
    def show
        render "pages/#{params[:page]}"
    end
end
