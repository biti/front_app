FrontApp.Shopping.Cart =
  
  init: ->
    _this = this
    store = 'cart'
    
    $('.quantity-input').change ->
      $this = $(this)
      quantity = parseInt( $this.val() )
      itemId   = parseInt( $this.attr('data-item-id') )
      
      items = JSON.parse( $.cookie(store) )
      
      newItems = _.map items, (item) -> 
        if item.id == itemId
          item.quantity = quantity
        item
      
      $.cookie("cart", JSON.stringify(newItems), { expires: 7, path: '/' })
      window.location.reload()
      
    $('.delete-button').click ->
      $this = $(this)
      
      itemId = parseInt( $this.attr('data-item-id') )
      
      items = JSON.parse( $.cookie(store) )
      newItems = _.reject items, (item) -> item.id == itemId
      
      $.cookie(store, JSON.stringify(newItems), { expires: 7, path: '/' })
      window.location.reload()

    
