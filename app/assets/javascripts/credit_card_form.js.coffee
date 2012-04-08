jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  payment.setupForm()
  $('input[type=submit]').button()

payment =
  setupForm: ->
    $('#new_payment').submit ->
      $('input[type=submit]').button('loading')
      payment.processCard()
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, payment.handleStripeResponse)
    return false
  
  handleStripeResponse: (status, response) ->
    # $('input[type=submit]').button('reset')

    if status == 200
      console.log response
      $('#stripe_error').hide()
      $('#stripe_card_token').val response.id
      $('#stripe_card_last4').val response.card.last4
      $('#stripe_card_type').val response.card.type
      $('#new_payment')[0].submit()
    else
      $('#stripe_error').show()
      $('#stripe_error').text(response.error.message)