class ArticlesController < ApplicationController 
    before_action :authenticate_user!

    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end
    
    def new
        @article=current_user.articles.build
    end
    
    def edit
        @article=Article.find(params[:id])
    end
    
    def create
        @article = current_user.articles.build(params.require(:article).permit(:title, :text))
        if @article.save
            redirect_to @article
        else
            render 'new'
        end
    end
    
    def update
        @article=Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :text))
            redirect_to @article
        else
            render 'edit'
        end
    end
    
    def destroy
        @article=Article.find(params[:id])
        @article.destroy
        
        redirect_to articles_path
    end

end
