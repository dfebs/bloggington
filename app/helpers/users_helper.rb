module UsersHelper
  include Rails.application.routes.url_helpers

  def profile_picture(user, max_width)
    image_tag asset_path("defaultpp.png"), style: "max-width: #{max_width}px;"
  end
end
