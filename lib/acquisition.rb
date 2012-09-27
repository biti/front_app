module Acquisition
  def Acquisition.retrieve_domain_name(url)
    m = %r{^(?:[[:alnum:]]+://)?((?:[\w-]+\.)+[[:alpha:]]+)(?::\d+)?(?:/.*)?$}.match(url)
    m && m[1]
  end
end
