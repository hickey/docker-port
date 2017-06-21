
module Semi
  class ValidationError < RuntimeError; end

  module_function
  def validate(value, rules)
    if rules.class == String
      rules = rules.split(/,\s?/)
    end
    tests = Hash[ rules.collect { |r| [r, false] } ]

    tests.keys.each do |rule|
      case rule
      when 'required'
        tests[rule] = true unless value.nil?
      when 'integer'
        tests[rule] = Semi::Variables::Integer.validate(value)
      when 'string'
        tests[rule] = Semi::Variables::String.validate(value)
      when 'boolean'
        tests[rule] = Semi::Variables::Boolean.validate(value)
      when 'path'
        tests[rule] = Semi::Variables::Path.validate(value)
      when 'url'
        tests[rule] = Semi::Variables::Url.validate(value)
      end

      # test for regular expression
      if rule.start_with?('/') and rule.end_with?('/')
        re = Regexp.new(rule[1..-2])
        tests[rule] = true if re.match(value.to_s)
      end
    end

    failures = tests.each_pair.map { |r,t| r if not t }.compact
    unless failures.empty?
      raise ValidationError, "#{value}(#{value.class}) does not validate against #{failures} rules"
    end
  end
end
