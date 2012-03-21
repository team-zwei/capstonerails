$("#cc_validate_form").validateCreditCard (result) ->
  alert "CC type: " + result.card_type + "\nLength validation: " + result.length_valid + "\nLuhn validation: + result.luhn_valid"