module UsersHelper
  def profile_picture(user, max_width)
    if user.profile_picture.attached?
      image_tag user.profile_picture, style: "max-width: #{max_width}px;"
    else
      image_tag asset_path("defaultpp.png"), style: "max-width: #{max_width}px"
    end
  end
end
