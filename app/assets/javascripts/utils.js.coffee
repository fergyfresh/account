@amountFormat = (amount) ->
  '$ ' + amount.toFixed(2)

@hourFormat = (amount) ->
  amount.toFixed(1)

@totalFormat = (amount, isHours) ->
  if isHours
    @hourFormat(amount)
  else
    @amountFormat(amount)
