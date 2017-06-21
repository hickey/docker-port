require 'spec_helper'

describe Semi::Variables::Url do

  [
    # Test string,                          pass?
    ['http://web.com',                      'http://web.com'],
    ['http://web.com/',                     'http://web.com/'],
    ['https://www.help.org',                'https://www.help.org'],
    ['ftp://ftp.org/foo',                   'ftp://ftp.org/foo'],
    ['http://host.com:8080/',               'http://host.com:8080/'],
    ['http://www/',                         'http://www/'],
    ['http://some.host.com/page.html',      'http://some.host.com/page.html'],
    ['http://a.com/page?key=val',           'http://a.com/page?key=val']
  ].each do |test|
    it "set '#{test[0]}' as #{test[1]}" do
      expect(Semi::Variables::Url.new(test[0]).value).to eq test[1]
    end
  end
  
  [
    'htt://www.host.com',
    'https:///foo.bar.com/',
    'file:///some/file/path/doc.txt',
  ].each do |test|
    it "rejects '#{test}'" do
      expect{Semi::Variables::Url.new(test)}.to raise_error(Semi::VariableError)
    end
  end

  let (:url)  {Semi::Variables::Url.new('https://www:994/short/path/file.name?q=foo&e=bar')}

  it "#proto returns https" do
    expect(url.proto).to eq 'https'
  end
  
  it "#host returns www" do
    expect(url.host).to eq 'www'
  end
  
  it "#port returns 994" do
    expect(url.port).to eq '994'
  end
  
  it "#path returns short/path" do
    expect(url.path).to eq 'short/path'
  end
  
  it "#file returns file.name" do
    expect(url.file).to eq 'file.name'
  end
  
  it "#params returns q=foo&e=bar" do
    expect(url.params).to eq 'q=foo&e=bar'
  end
  
end
