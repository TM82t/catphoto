class SearchsController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method).page(params[:page]).per(5)
  end

  private
  def search_for(model, content, method)
    if model == 'end_user'
      if method == 'perfect'
        EndUser.where(end_user_name: content)
      else
        EndUser.where('end_user_name LIKE ?', '%' + content + '%')
      end
    elsif model == 'post'
      if method == 'perfect'
        Post.where(name: content)
      else
        Post.where('name LIKE ?', '%' + content + '%')
      end
    end
  end

end
