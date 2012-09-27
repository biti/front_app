module ShippingAddressesHelper
  def settle(region, level)
    return nil if region.nil? || region.level < level
    while region.level > level
      region = region.parent
    end
    region
  end
end
