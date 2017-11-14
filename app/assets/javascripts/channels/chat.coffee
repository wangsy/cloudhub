App.chat = App.cable.subscriptions.create {channel: "ChatChannel", room: "some_channel"},
  connected: ->
    # Called when the subscription is ready for use on the server
    $("[data-chat-room='Best Room']").append("connected<br />")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $("[data-chat-room='Best Room']").append(html)

  createLine: (data) ->
    """
    <span>Added <a href="/cloud_resources/#{data["resource_id"]}">#{data["body"]}</a></span><br />
    """
