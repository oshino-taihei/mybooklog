class CategoriesController < ApplicationController
  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = current_user.categories.all
    @category = current_user.categories.build
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: 'カテゴリーを更新しました' }
        format.json { head :no_content }
      else
        format.html { render :index }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @category = current_user.categories.build(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'カテゴリーを追加しました' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html do
          @categories = current_user.categories.all
          render :index
        end
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_path, notice: 'カテゴリーを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    def category_params
      params.require(:category).permit(:category_name)
    end

    def set_category
      @category = Category.find(params[:id])
    end
end
