jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  payment.setupForm()
  $('input[type=submit]').button()
  $('input[type=radio].saved_card').click toggle_cc_form
  
  $('#new_card_button').click ->
    toggle_cc_form(true)
    toggle_saved_card_form(false)
    $('input[type=radio].saved_card').prop("checked", false)
    false

  $('.payment_method').children().each ->
    if ( ! $(this).hasClass('delete_cell'))
      $(this).click ->
        $(this).parent().find('.payment_method_select_cell > input').prop("checked", true)

        toggle_cc_form(false)
        toggle_saved_card_form(true)
        false

toggle_cc_form = (show) ->
  stripe_payment = $('#stripe_payment')
  
  if show
    stripe_payment.show()
  else
    stripe_payment.hide()

toggle_saved_card_form = (show) ->
  new_card = $('#new_card')

  if show
    new_card.show()
  else
    new_card.hide()

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