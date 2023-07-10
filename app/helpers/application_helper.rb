module ApplicationHelper

  def avatar_url(end_user)
      return end_user.profile_photo.url unless end_user.profile_photo.nil?
      return "https://techpit-market-prod.s3.amazonaws.com/uploads/part_attachment/file/15782/2da91636-af73-4eed-91cd-320a0399609c.jpg"
  end
end
