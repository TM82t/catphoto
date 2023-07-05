class Public::HomesController < ApplicationController

  def top
    @posts = Post.page
  end

end