jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  payment.setupForm()
  $('input[type=submit]').button()
  $('input[type=radio].saved_card').click toggle_cc_form
  $('#new_card_button').click toggle_cc_form

toggle_cc_form = ->
  stripe_payment = $('#stripe_payment')
  new_card = $('#new_card')

  if stripe_payment.is(":visible")
    stripe_payment.hide()
    new_card.show()
  else if new_card.not(":visible")
    new_card.hide()
    stripe_payment.show()
  
  if this.id == "new_card_button"
    $('input[type=radio].saved_card').prop("checked", false)
    false

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
      $('input[type=submit]').button('reset')
      $('#stripe_error').show()
      $('#stripe_error').text(response.error.message)