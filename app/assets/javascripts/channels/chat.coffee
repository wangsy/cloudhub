App.chat = App.cable.subscriptions.create {channel: "ChatChannel"},
  connected: ->
    # Called when the subscription is ready for use on the server
    $("[data-chat-room='Best Room']").append("connected<br />")

  disconnected: ->
    $("[data-chat-room='Best Room']").append("disconnected<br />")

  rejected: ->
    $("[data-chat-room='Best Room']").append("rejected<br />")

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if data["body"] == "downloaded_thumbnail"
      $("[data-src='"+data["resource_id"]+"']").attr('src', data["resource_id"])
    else
      @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $("[data-chat-room='Best Room']").append(html)

  createLine: (data) ->
    """
    <span>Added <a href="/cloud_resources/#{data["resource_id"]}">#{data["body"]}</a></span><br />
    """
