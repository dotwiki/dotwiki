module ResizeClimageHelper
  def resize_climage(path, opt)
    if Rails.env.production?
      # https://res.cloudinary.com/dotwiki/image/upload/v1581132842/thyswdnpefll9yageewh.png
      base_url = 'https://res.cloudinary.com/dotwiki/image/upload/'
      path.slice!(base_url)
      base_url + opt + '/' + path
    else
      path
    end
  end
end
