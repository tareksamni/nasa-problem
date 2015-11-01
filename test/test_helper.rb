def is_int(str)
  !!Integer(str)
rescue ArgumentError, TypeError
    false
end