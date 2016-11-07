def int?(str)
  !!Integer(str)
rescue ArgumentError, TypeError
  false
end
