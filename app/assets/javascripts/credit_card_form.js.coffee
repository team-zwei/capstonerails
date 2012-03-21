jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  payment.setupForm()

payment =
  setupForm: ->
    $('#new_payment').submit ->
      $('input[type=submit]').attr('disabled', true)
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
    if status == 200
      console.log response
      $('#stripe_card_token').val response.id
      $('#stripe_card_last4').val response.card.last4
      $('#new_payment')[0].submit
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)