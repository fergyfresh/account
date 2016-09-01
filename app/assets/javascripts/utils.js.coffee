@amountFormat = (amount) ->
  '$ ' + Number(amount).toLocaleString()

@hourFormat = (amount) ->
  Number(amount).toLocaleString()
