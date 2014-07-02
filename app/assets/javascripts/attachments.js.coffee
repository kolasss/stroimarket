class @AttachmentButton
  constructor: (@options = {}) ->
    @el = $ options.el
    @initialize(options)

  initialize: (options) ->
    @bindEvents()

  bindEvents: ->
    @el.on 'click', (e) =>
      @populateFields()
      e.preventDefault()

  populateFields: ->
    tpl = $ @template()
    fields = new AttachmentFields el: tpl
    @el.before(tpl)

  template: ->
    tpl = @el.data('item-tpl')
    id = new RegExp(@el.data('id'), 'g')

    tpl.replace(id, new Date().getTime())


class @AttachmentFields
  constructor: (@options = {}) ->
    @el = $ options.el
    @initialize(options)

  initialize: (options) ->
    @closeBtn = @el.find('.close').first()
    @removeInput = @el.find('.attachment-destroy').first()
    @imageUploader = @el.find('.image-uploader').first()

    if @imageUploader.length
      new ImageUploader el: @imageUploader

    @bindEvents()

  bindEvents: ->
    @closeBtn.on 'click', (e) =>
      @remove()
      e.preventDefault()

  remove: ->
    @el.hide 'fast', =>
      if @removeInput.length
        @removeInput.val(true)
      else
        @el.remove()


class @ImageUploader
  constructor: (@options = {}) ->
    @el = $ options.el
    @initialize(options)

  initialize: (options) ->
    @preview     = @el.find('.image-preview').first()
    @fileInput   = @el.find('.image-file').first()
    @removeInput = @el.find('.image-remove').first()
    @closeBtn    = @el.find('.close').first()

    @bindEvents()
    @hideControls() unless @isPreviewSet()

  bindEvents: ->
    @fileInput.on 'change', (e) =>
      @setupPreview(e.target.files[0])

    @closeBtn.on 'click', (e) =>
      e.preventDefault()
      @resetPreview()

  setupPreview: (file) ->
    return unless file.type in @fileInput.attr('accept').split(/,\s*/)

    reader = new FileReader
    reader.onload = =>
      @preview.attr('src', reader.result)
      @removeInput.val(false)
      @showControls()

    reader.readAsDataURL(file)

  isPreviewSet: ->
    @preview.attr('src') isnt ''

  resetPreview: ->
    @fileInput.val('')
    @removeInput.val(true)
    @hideControls()

  showControls: ->
    @preview.show()
    @closeBtn.show()

  hideControls: ->
    @preview.hide()
    @closeBtn.hide()
