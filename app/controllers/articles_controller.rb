class ArticlesController < ApplicationController
    before_action :set_article, except: [:new, :create, :index]
    before_action :check_api_key, except: [:show, :index]

    def index
        @articles = Kaminari.paginate_array(Article.order_by(created_at: :desc)).page(params[:page]).per(4)
    end

    def show
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true, fenced_code_blocks: true)
        @content = markdown.render(@article.content)

        title(@article.title)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new
        process_article
    end

    def edit
        process_article
    end

    def update
        process_article
    end

    def destroy
        @article.destroy
        flash[:success] = "Article supprimé"
    end

    private
    def article_params
        params.require(:article).permit(:title, :content)
    end

    def set_article
        @article = Article.find(params[:id])
    end

    def check_api_key
        unless params[:api] == ENV['BLOG_API_KEY']
            flash[:error] = "La clé API fournie n'est pas correcte"
            redirect_to blog_index_path
        end
    end

    def process_article
        @article.assign_attributes(article_params)

        if @article.save?
            flash[:success] = "Success"
        else
            flash[:error] = "Erreur"
        end

        redirect_to blog_index_path
    end
end
