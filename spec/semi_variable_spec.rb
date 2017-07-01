require 'spec_helper'


describe Semi::Variable do

  [
    # value,                 var type,                     hints
    ['/etc/passwd',          'Semi::Variables::Path',      nil],
    ['./file.txt',           'Semi::Variables::Path',      nil],
    ['~root/.bashrc',        'Semi::Variables::Path',      nil],
    ['../../bin/ls',         'Semi::Variables::Path',      nil],
    ['/etc/passwd',          'Semi::Variables::Path',      'path'],
    ['./file.txt',           'Semi::Variables::Path',      'path'],
    ['~root/.bashrc',        'Semi::Variables::Path',      'path'],
    ['../../bin/ls',         'Semi::Variables::Path',      'path'],
    ['/etc/passwd',          'Semi::Variables::String',    'string'],
    ['./file.txt',           'Semi::Variables::String',    'string'],
    ['~root/.bashrc',        'Semi::Variables::String',    'string'],
    ['../../bin/ls',         'Semi::Variables::String',    'string'],
    [849234,                 'Semi::Variables::Integer',   nil],
    [0x8849,                 'Semi::Variables::Integer',   nil],
    [7_849,                  'Semi::Variables::Integer',   nil],
    ['849234',               'Semi::Variables::String',    nil],
    ['0x8849',               'Semi::Variables::String',    nil],
    ['7_849',                'Semi::Variables::String',    nil],
    ['849234',               'Semi::Variables::Integer',   'integer'],
    ['0x8849',               'Semi::Variables::Integer',   'integer'],
    ['7_849',                'Semi::Variables::Integer',   'integer'],
    [true,                   'Semi::Variables::Boolean',   nil],
    [false,                  'Semi::Variables::Boolean',   nil],
    ['true',                 'Semi::Variables::Boolean',   nil],
    ['false',                'Semi::Variables::Boolean',   nil],
    ['on',                   'Semi::Variables::Boolean',   nil],
    ['off',                  'Semi::Variables::Boolean',   nil],
    ['yes',                  'Semi::Variables::Boolean',   nil],
    ['no',                   'Semi::Variables::Boolean',   nil],
    ['enable',               'Semi::Variables::Boolean',   nil],
    ['disable',              'Semi::Variables::Boolean',   nil],
    ['TRUE',                 'Semi::Variables::Boolean',   nil],
    ['FALSE',                'Semi::Variables::Boolean',   nil],
    ['ON',                   'Semi::Variables::Boolean',   nil],
    ['OFF',                  'Semi::Variables::Boolean',   nil],
    ['YES',                  'Semi::Variables::Boolean',   nil],
    ['NO',                   'Semi::Variables::Boolean',   nil],
    ['ENABLE',               'Semi::Variables::Boolean',   nil],
    ['DISABLE',              'Semi::Variables::Boolean',   nil],
    ['True',                 'Semi::Variables::Boolean',   nil],
    ['False',                'Semi::Variables::Boolean',   nil],
    ['On',                   'Semi::Variables::Boolean',   nil],
    ['Off',                  'Semi::Variables::Boolean',   nil],
    ['Yes',                  'Semi::Variables::Boolean',   nil],
    ['No',                   'Semi::Variables::Boolean',   nil],
    ['Enable',               'Semi::Variables::Boolean',   nil],
    ['Disable',              'Semi::Variables::Boolean',   nil],
    ['true',                 'Semi::Variables::Boolean',   'boolean'],
    ['false',                'Semi::Variables::Boolean',   'boolean'],
    ['on',                   'Semi::Variables::Boolean',   'boolean'],
    ['off',                  'Semi::Variables::Boolean',   'boolean'],
    ['yes',                  'Semi::Variables::Boolean',   'boolean'],
    ['no',                   'Semi::Variables::Boolean',   'boolean'],
    ['enable',               'Semi::Variables::Boolean',   'boolean'],
    ['disable',              'Semi::Variables::Boolean',   'boolean'],
    ['true',                 'Semi::Variables::String',    'string'],
    ['false',                'Semi::Variables::String',    'string'],
    ['on',                   'Semi::Variables::String',    'string'],
    ['off',                  'Semi::Variables::String',    'string'],
    ['yes',                  'Semi::Variables::String',    'string'],
    ['no',                   'Semi::Variables::String',    'string'],
    ['enable',               'Semi::Variables::String',    'string'],
    ['disable',              'Semi::Variables::String',    'string'],
    ['http://www.google.com/', 'Semi::Variables::Url',     nil],
    ['https://www.google.com/', 'Semi::Variables::Url',    nil],
    ['http://www.google.com', 'Semi::Variables::Url',      nil],
    ['https://www.google.com', 'Semi::Variables::Url',     nil],
    ['https://www.google.com:80/', 'Semi::Variables::Url', nil],
    ['http://www.google.com:808/', 'Semi::Variables::Url', nil],
    ['http://www.google.com:8080/', 'Semi::Variables::Url', nil],
    ['https://www.google.com:80808/', 'Semi::Variables::Url', nil],
    ['https://www.google.com:80', 'Semi::Variables::Url',  nil],
    ['http://www.google.com:808', 'Semi::Variables::Url',  nil],
    ['http://www.google.com:8080', 'Semi::Variables::Url', nil],
    ['https://www.google.com:80808', 'Semi::Variables::Url', nil],
    ['ftp://ftp.ftp.com',    'Semi::Variables::Url',       nil],
    ['ftp://ftp.com/',       'Semi::Variables::Url',       nil],
    ['ftp://ftp.com/foo.baz', 'Semi::Variables::Url',      nil],
    ['ftp://ftp.com/foo/bar/foo.baz', 
                             'Semi::Variables::Url',       nil],
    ['http://www/',          'Semi::Variables::Url',       nil],
    ['http://www',           'Semi::Variables::Url',       nil],
    ['http://www:888',       'Semi::Variables::Url',       nil],
    ['http://www/some/file', 'Semi::Variables::Url',       nil],
    ['http:/www/',           'Semi::Variables::Path',      nil],
    
  ].each do |test|
    it "#import identifies #{test[0]} as #{test[1]}" do
      if test[2].nil?
        # no hints given
        expect(Semi::Variable.import(test[0]).class.to_s).to eql test[1]
      else
        expect(Semi::Variable.import(test[0], test[2]).class.to_s).to eql test[1]
      end
    end
  end

  dictionary = {'one'   => Semi::Variables::Integer.new(1),
                'two'   => Semi::Variables::Integer.new(2),
                'alpha' => Semi::Variables::String.new('a'),
                'beta'  => Semi::Variables::String.new('b')}

  [  #value,                 #expected
    ['abc123',               'abc123'],
    ['a$alpha',                'aa'],
    ['a$ALPHA',                'aa'],
    ['a${alpha}',              'aa'],
    ['a${ALPHA}',              'aa'],
    ['## $alpha / $beta ++',   '## a / b ++'],
    ['## $ALPHA / $BETA ++',   '## a / b ++'],
  ].each do |test|
    it "#expand transforms '#{test[0]}' to '#{test[1]}'" do
      expect(Semi::Variable::expand(test[0], dictionary)).to eql test[1]
    end
  end
  
end