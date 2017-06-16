
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
        tests[rule] = true if value.is_a? Integer
      when 'string'
        tests[rule] = true if value.is_a? String
      when 'boolean'
        tests[rule] = true if value.is_a? Boolean
      end

      # test for regular expression
      if rule.start_with?('/') and rule.end_with?('/')
        re = Regexp.new(rule[1..-2])
        tests[rule] = true if re.match(value)
      end
    end

    failures = tests.each_pair.map { |r,t| r if not t }.compact
    unless failures.empty?
      raise ValidationError, "#{value} does not validate against #{failures} rules"
    end
  end
end
