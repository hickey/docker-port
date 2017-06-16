require 'spec_helper'

describe "Semi::validator" do

  [
    [10,         'integer',                        true],
    [10,         ['integer'],                      true],
    ['10',       'integer',                        false],
    ['10',       ['integer'],                      false],
    ['foobar',   'string',                         true],
    ['foobar',   ['string', 'required'],           true],
    ['foobar',   'string,required',                true],
    ['foobar',   'string, required',               true],
    ['foobar',   '/foo/',                          true],
    ['foobar',   '/fubar/',                        false],
    ['foobar',   ['/foo/'],                        true],
    ['foobar',   ['/fubar/'],                      false],
    [nil,        'required',                       false],
    [nil,        ['required'],                     false]
   ].each do |ruleset|
    it "validates #{ruleset[0]} against #{ruleset[1]}" do
      if ruleset[2] == true
        expect {Semi::validate(ruleset[0], ruleset[1])}.not_to raise_error
      else
        expect {Semi::validate(ruleset[0], ruleset[1])}.to raise_error(Semi::ValidationError)
      end
    end
  end

end