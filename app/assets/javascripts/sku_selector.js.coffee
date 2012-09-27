#
# 规格选择
#
(($) ->
  
  # 是否数字
  isNumber = (s) ->
    regu = "^[0-9]+$"
    re = new RegExp(regu)
    $.trim(s).search(re) isnt -1
    
  # 添加到购物车
  addToCart = (container, datas) ->

    unless skuSelected(container, datas)
      alert '请选择颜色尺码'
      return false

    quantityInput = $("#" + datas.quantityInput)
    quantity = quantityInput.val()
    if !isNumber(quantity)
      alert("请填写购买数量")
      return false
      
    quantity = parseInt(quantity)
    if quantity <= 0
      alert("购买数量必须大于0")
      return false
      
    sku = findSku(container, datas)
    if sku is {}
      alert("库存卖光了")
      return false
    
    items = JSON.parse( $.cookie('cart') )
    inCart = false
    newItems = []
    newItems = _.map items, (item) -> 
      if item.id == sku.id
        item.quantity += quantity
        inCart = true
      item
      
    unless inCart
      newItems.push( {id: sku.id, quantity: quantity} )
    
    $.cookie("cart", JSON.stringify(newItems), { expires: 7, path: '/' } )
    window.location = '/shopping/cart'
  
  # 直接购买
  buy = (container, datas) ->
    unless skuSelected(container, datas)
      alert '请选择颜色尺码'
      return false

    quantityInput = $("#" + datas.quantityInput)
    quantity = quantityInput.val()
    
    if !isNumber(quantity)
      alert("请填写购买数量")
      return false
      
    quantity = parseInt(quantity)
    if quantity <= 0
      alert("购买数量必须大于0")
      return false
      
    sku = findSku(container, datas)
    if sku is {}
      alert("库存卖光了")
      return false
      
    window.location = '/shopping/direct_order?sku_id=' + sku.id + '&quantity=' + quantity
    

  # 根据选择的
  findSku = (container, datas) ->
    
    lis = container.find("li[class=\"gg-selected\"]")
      
    a = _.map(lis, (li) -> $(li).attr('gg-name') + $(li).attr('gg-value') ).join()
    
    for sku in datas.skus
      b = _.map(sku.specification, (item) -> item.property + item.value).join()
      if a is b
        return sku
    
    return {}
        
  
  # 判断全部规格是否都选了
  skuSelected = (container, datas) ->
    selectedOptionsNumber = container.find("[class=\"gg-selected\"]").length
    shouldSelectedOptionsNumber = datas.properties.length
    selectedOptionsNumber is shouldSelectedOptionsNumber
  
  # 选则规格并根据选定的规格显示或隐藏其他规格
  selectProperty = (option, container, datas) ->
    if option.attr('class') is 'gg-selected'
      # 取消选定
      option.attr('class', '')

      # 取消异组选项没有库存的置灰状态
      container.find("li[gg-name!='" + option.attr('gg-name') + "']").filter("[class='disabled']").attr('class', '')      
    else
      # 取消同组已经选中的选项
      container.find("li[gg-name='" + option.attr('gg-name') + "']").filter("[class='gg-selected']").attr('class', '')
      
      # 选定选项
      option.attr('class', 'gg-selected')

      # 所有异组选项
      options = container.find("li[gg-name!='" + option.attr('gg-name') + "']").filter("[class!='gg-selected']")
      options.attr('class', '')
      
      has_stock_values = hasStockOptions( option.attr('gg-name'), option.attr('gg-value'), datas.skus )

      # 异组选项没有库存的置灰
      _.each options, (option) ->
        $(option).attr('class', 'disabled') unless _.include(has_stock_values, $(option).attr('gg-value'))
    
  # 寻找匹配的有库存的选项
  hasStockOptions = (property, value, skus) ->
    result = []
    
    for sku in skus
      if sku.num > 0 && _.find(sku.specification, (item) -> item.property is property && item.value is value)
        result.push _.find(sku.specification, (item) -> item.property isnt property).value
  
    result
  
  # 根据label,tag创建一个dl元素
  generateDl = (label, tag) ->
    dl = $("<dl class=\"clearfix\"/>")
    dl.append $("<dt/>").html(label)
    dl.append $("<dd/>").html(tag)
    dl

  $.fn.skuSelector = (options) ->
    opts = $.extend({}, $.fn.skuSelector.defaults, options)
    
    @each ->
      $this = $(this)
      
      o = (if $.meta then $.extend({}, opts, $this.data()) else opts)
      $this.data "options", o
      $.fn.skuSelector.renderHtml $this, o

      # findSku $this, o, true

      $("#" + o.orderButtonId).click ->
        buy $this, o

      $("#" + o.addToCartButtonId).click ->
        addToCart $this, o

  $.fn.skuSelector.defaults = backgroundImage: "/images/tip-box.gif"
  
  $.fn.skuSelector.renderHtml = (container, options) ->
    for property in options.properties
      ul = $("<ul/>").attr("property", property.label)
      
      for choice in property.choices
        a = $("<a/>").attr("href", "javascript:;").append("<span>" + choice + "</span>").click ->
          $this = $(this)
          selectProperty $this.parent(), container, options
          # findSku container, options, false
        
        ul.append $("<li/>").attr("gg-name", property.label).attr("gg-value", choice).append(a).append("<em></em>")
        
      dl = $("<dl class='clearfix'/>").append( $("<dt/>").html(property.label)).append($("<dd/>").html(ul) )
        
      if property.choices.length is 1
        dl.find("li").first().attr "class", "gg-selected"
          
      container.append dl
      
    input = $("<input/>").attr("type", "text").attr("id", options.quantityInput).attr("class", "ss-input")
    
    container.append '数量：'
    container.append input
    
) jQuery