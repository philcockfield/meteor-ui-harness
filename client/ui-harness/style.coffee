WHITE = { r:255, g:255, b:255, a:1 }
BLACK = { r:0, g:0, b:0, a:1 }


###
Provides style methods for visually configuring the harness.
###
PKG.Style = stampit().enclose ->
  hash = new ReactiveHash(onlyOnChange:true)
  harness = null


  # PUBLIC ----------------------------------------------------------------------


  ###
  Initializes the style object.
  @param options
            - harness: (Optional) The UIHarness to use.

  ###
  @init = (options = {}) ->
    harness = options.harness ?= UIHarness
    @


  ###
  Resets the styles to their original state.
  ###
  @reset = ->
    @background(null)
    @border(null)
    @


  # ----------------------------------------------------------------------


  ###
  REACTIVE: Gets or set the background style.
  @param value:
            - string: A color style value.
            - number: - 0..1 alpha percentage of black (eg. 0.3 == 30%)
  ###
  @background = (value) ->
    result = hash.prop 'background', value, default:null
    toStyle = (value) ->
        return WHITE if not value?
        if Util.isNumeric(value)
          number = value.toNumber()
          number = 0 if number < 0
          number = 1 if number > 1

          return WHITE if number is 1
          return BLACK if number is 0
          return { r:0, g:0, b:0, a:number }

        # Default value.
        value


    toStyle(result)


  ###
  REACTIVE: Gets or sets the border style.
  ###
  @border = (value) ->
    result = hash.prop 'border', value, default:null

    toStyle = (value) ->
        return 'none' if not Object.isString(value)
        value = value.toLowerCase()
        DEFAULT_OPACITY = 0.2
        switch value
          when 'dashed' then value = "dashed 1px rgba(0,0,0,#{ DEFAULT_OPACITY })"
          when 'solid' then value = "solid 1px rgba(0,0,0,#{ DEFAULT_OPACITY })"
          else
            # Use the given style value.

        value


    toStyle(result)






  # ----------------------------------------------------------------------
  return @


