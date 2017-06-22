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
    [nil,        ['required'],                     false],
    ['/etc/passwd', 'path',                        true],
    ['../parent', ['path'],                        true],
    ['.005',      'path',                          true],
    ['file.name', 'path',                          false],
    ['~user',     'path',                          true],
    ['~user/dir/file', 'path',                     true],
    ['http://www.simple.com', 
                  'url',                           true],
    ['http://abit.more.complex.com/',
                  'url',                           true],
    ['http://www.complex.com:8080/some/page.html',
                  'url',                           true],
    ['http://really.complex.com:888/a/lot/of/dirs/1/2/3/4/5/p.json?key=value&key2=val2',
                  'url',                           true],
    ['no',        'boolean',                       true],
    ['false',     'boolean',                       true],
    ['yes',       'boolean',                       true],
    ['true',      'boolean',                       true],
    ['enable',    'boolean',                       true],
    ['disable',   'boolean',                       true]
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