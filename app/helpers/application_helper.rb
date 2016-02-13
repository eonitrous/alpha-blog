module ApplicationHelper

  #method to connect to gravtar service using MD5 email information
  def gravatar_for(user, options = { size: 80 } )
      # create MD5 hash from user.email
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
      # create URL to connect to gravatar service
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      # display the image within a circle
    image_tag(gravatar_url, alt: user.username, class: "img-circle")

  end

end
