# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @submitted_posts = Post.submitted.includes(:user) if current_user.admin?
  end
end
