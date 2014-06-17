app.factory 'FilterCatalog', ['filterFilter', '$filter', 'SortingCatalog', '$rootScope', (filterFilter, $filter, SortingCatalog, $rootScope) ->
  new class FilterCatalog
    constructor: ->
      @filter =
        subcats: []
      @current =
        products: []

    #counters
    count_products_for_category: (subcats_counter, manufacturers_counter, manufacturers) ->
      for item in manufacturers
        manufacturers_counter[item.title] = 0

      for item in @current.children
        subcats_counter[item.id] = 0

      for item in @current.products
        manufacturers_counter[item.manufacturer_title] += 1 if item.manufacturer_title

        if item.category_id.$oid != @current.id
          if item.category_id.$oid of subcats_counter
            subcats_counter[item.category_id.$oid] += 1
          else
            for subcat in @current.children
              if item.category_id.$oid in subcat.children_ids
                subcats_counter[subcat.id] += 1
                break

    count_products_for_store: (cats_counter, categories) ->
      for item in categories
        cats_counter[item.id] = 0

      for item in @current.products
        if item.category_id.$oid of cats_counter
          cats_counter[item.category_id.$oid] += 1
        else
          for subcat in categories
            if item.category_id.$oid in subcat.children_ids
              cats_counter[subcat.id] += 1
              break

    count_services: (cats_counter, categories) ->
      for item in categories
        cats_counter[item._id.$oid] = 0

      for item in @services
        cats_counter[item.service_category_id.$oid] += 1

    #filtering
    initFilter: (fltr, cur) ->
      @filter = fltr
      # currentCategory or currentStore
      @current = cur

    initFilterServices: (fltr, srvices) ->
      @filter = fltr
      @services = srvices

    initFilterSearch: (fltr, cur, srvices) ->
      @filter = fltr
      @current = cur
      @services = srvices


    toggleBrand: (manufacturer) ->
      idx = @filter.manufacturers.indexOf(manufacturer)
      if idx > -1
        @filter.manufacturers.splice(idx, 1)
      else
        @filter.manufacturers.push(manufacturer)

    toggleSubcat: (subcat_id, children_ids) ->
      ids = if children_ids? then children_ids.concat(subcat_id) else [subcat_id]
      for id in ids
        idx = @filter.subcats.indexOf(id)
        if idx > -1
          @filter.subcats.splice(idx, 1)
        else
          @filter.subcats.push(id)

    filteredProducts: ->
      result = @current.products

      # string search
      result = filterFilter(result, @filter.query) if @filter.query

      # price range
      result = $filter('priceRangeCatalog')(result, @filter) if @filter.minPrice or @filter.maxPrice

      # by manufacturer
      result = $filter('productByManufacturer')(result, @filter) if @filter.manufacturers

      # by subcategory
      result = $filter('productByCategory')(result, @filter) if @filter.subcats

      $rootScope.$broadcast 'ProductNumberOfPages:updated', Math.ceil(result.length/SortingCatalog.pageSize) if result

      return result

    filteredServices: ->
      result = @services

      # string search
      result = filterFilter(result, @filter.query) if @filter.query

      # price range
      result = $filter('priceRangeCatalog')(result, @filter) if @filter.minPrice or @filter.maxPrice

      # by subcategory
      result = $filter('serviceByCategory')(result, @filter) if @filter.subcats

      $rootScope.$broadcast 'ServiceNumberOfPages:updated', Math.ceil(result.length/SortingCatalog.pageSize) if result

      return result

    clear_filter: ->
      @filter =
        subcats: []

]
