require 'acquisition'
require 'admin'

module LoginHelper
  def background_image
    referer = request.headers()['Referer']
    pages = []
    if referer
      domain = Acquisition.retrieve_domain_name(referer)
      r = domain && Admin::LandingPage.select(:domain).where(:domain => set_out(domain)).uniq.order('length(domain) desc').first
      pages = Admin::LandingPage.where(:domain => r.domain) if r
      pages = Admin::LandingPage.where(:domain => DOMAIN_ANY) if pages.empty?
    end
    pages = Admin::LandingPage.where(:domain => DEFAULT) if pages.empty?
    pages.empty? || pages.sample.background_image
  end

  # ------------------------------------------------------------
  private

  DEFAULT = nil
  DOMAIN_ANY = '*'

  def set_out url
    s = url.split(/\./)
    (0 .. s.length - 2).collect { | i | s[i .. -1].join('.') }
  end
end
