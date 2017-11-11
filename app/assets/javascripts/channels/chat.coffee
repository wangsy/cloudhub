App.chat = App.cable.subscriptions.create {channel: "ChatChannel", room: "some_channel"},
  connected: ->
    # Called when the subscription is ready for use on the server
    @appendLine({body: "connected"})


  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    @appendLine({body: "received"})
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $("[data-chat-room='Best Room']").append(html)

  createLine: (data) ->
    """
    <p>
      <span>#{data["body"]}</span>
    </p>
    """
