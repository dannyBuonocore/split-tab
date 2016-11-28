SplitTabView = require './split-tab-view'
{CompositeDisposable} = require 'atom'

module.exports = SplitTab =
  splitTabView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @splitTabView = new SplitTabView(state.splitTabViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @splitTabView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'split-tab:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @splitTabView.destroy()

  serialize: ->
    splitTabViewState: @splitTabView.serialize()

  toggle: ->
    console.log 'SplitTab was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
