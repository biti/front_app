require 'RMagick'
require 'digest/sha1'

class ResourcesController < ApplicationController

  include ApplicationHelper
  include Magick

  skip_before_filter :authorize, :only => [ :create ]

  def create
    render json:
      (((Subscriber.find_by_id(session[:subscriber_id]) ||
         Admin::Operator.find_by_id(session[:operator_id])) &&
        image = params[:load].content_type =~ %r{image/} &&
        commit(params[:load].read)) ?
       { :error => 0, :path => image, :url => resource_url(image) } :
       { :error => -1 })
  end

  # ------------------------------------------------------------
  private

  def commit(data)
    today = Date.today
    digest = Base64.urlsafe_encode64(Digest::SHA1.new.digest(data)).sub(/=+$/, '')
    image = Magick::Image.from_blob(data)
    path = File.join(today.strftime('%y'),
                     today.strftime('%m'),
                     today.strftime('%d'),
                     "#{digest}.#{image.first.format.downcase}")

    apath = resource_path path
    FileUtils.mkdir_p(File.dirname(apath))
    begin
      File.open(apath, File::CREAT | File::EXCL) do
        | flock |

        File.open(flock, 'wb') { | f | f.write data }
      end
    rescue Errno::EEXIST
      # ignored safely
    end

    path
  end

end
