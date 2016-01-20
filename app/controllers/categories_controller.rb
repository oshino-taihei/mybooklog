class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:update, :destroy]

  def index
    @category = current_user.categories.build
  end

  def update
    @category.update!(category_params)
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path, notice: 'カテゴリーを追加しました'
    else
      render :index
    end
  end

  def destroy
    @category.destroy!
    redirect_to categories_path, notice: 'カテゴリーを削除しました'
  end

  private
    def category_params
      params.require(:category).permit(:category_name)
    end

    def set_category
      @category = Category.find(params[:id])
    end
end
