jQuery(document).on 'turbolinks:load', ->
  answers = $('#answers')
  if answers.length > 0
    App.global_chat = App.cable.subscriptions.create {
      channel: "AsksChannel"
      ask_id: answers.data('ask-id')
    },
    connected: ->
    disconnected: ->
    received: (data) ->
      answers.append data['answer']
    send_answer: (answer, ask_id) ->
      @perform 'send_answer', answer: answer, ask_id: ask_id
  $('#new_answer').submit (e) ->
    $this = $(this)
    textarea = $this.find('#answer_body')
    if $.trim(textarea.val()).length > 1
      App.global_chat.send_answer textarea.val(),
      answers.data('ask-id')
      textarea.val('')
    e.preventDefault()
    return false 