# frozen_string_literal: true

module PostsHelper
  def status_badge(post)
    content_tag("span", post.status.titleize, class: [
      "badge badge-#{['primary', 'success', 'danger'][Post.statuses[post.status]]}"
    ])
  end
end
