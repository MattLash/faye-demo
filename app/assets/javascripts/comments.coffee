window.client = new Faye.Client('/faye')

jQuery ->
    client.subscribe '/comments', (payload) ->
        $('#comments').find('.media-list').prepend(payload.message) if payload.message
    $('#comments').submit -> $(this).find("input[type='submit']").val('Sending a message foo!').prop('disabled', true)    
    