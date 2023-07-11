module ApplicationHelper

  def avatar_url(end_user)
      return end_user.profile_photo.url unless end_user.profile_photo.nil?
      return "no_image.jpg"
  end
end
