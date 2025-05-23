module SubmissionsHelper
  def inject_feed_ad(index)
    if ((index + 1) % 3 == 0)
      render partial: 'feed_ad'
    end
  end
end
