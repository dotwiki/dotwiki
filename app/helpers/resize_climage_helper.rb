module ResizeClimageHelper
  def resize_climage(path, opt)
    if ENV["CLOUDINARY_API_KEY"].present?
      base_url = "https://res.cloudinary.com/#{ENV['CLOUDINARY_CLOUD_NAME']}/image/upload/"
      path.slice!(base_url)
      base_url + opt + '/' + path
    else
      path
    end
  end
end
