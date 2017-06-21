require 'spec_helper'

describe Semi::Variables::Path do

  [
    # Test string,
    '/',
    '/bin',
    '/usr/local/bin/csh',
    '~user',
    '~/.bashrc',
    '~looser/plan.txt',
    './test',
    '../../usr/bin/foobar',
    '.././.././test-file',
    '/tmp/backup~',
    '/home/user/.git/config',
    'sub/directory/file.txt',
  ].each do |test|
    it "stores '#{test}' correctly" do
      expect(Semi::Variables::Path.new(test).value).to eq test
    end
  end
  
  # Currently the regex used to identify paths allows almost 
  # any string.
  #[
  #  'foo.txt',
  #].each do |test|
  #  it "rejects '#{test}'" do
  #    expect{Semi::Variables::Path.new(test)}.to raise_error(Semi::VariableError)
  #  end
  #end

  context "with relative paths" do
    let (:path)  {Semi::Variables::Path.new('../some/dir/file.txt')}

    it "#path returns ../some/dir/" do
      expect(path.path).to eq '../some/dir/'
    end
  
    it "#file returns file.text" do
      expect(path.file).to eq 'file.txt'
    end
  end

  context "with absolute paths" do
    let (:path)  {Semi::Variables::Path.new('/some/dir/file.txt')}

    it "#path returns /some/dir/" do
      expect(path.path).to eq '/some/dir/'
    end
  
    it "#file returns file.text" do
      expect(path.file).to eq 'file.txt'
    end
  end

  context "with partial paths" do
    let (:path)  {Semi::Variables::Path.new('some/dir/file.txt')}

    it "#path returns some/dir/" do
      expect(path.path).to eq 'some/dir/'
    end
  
    it "#file returns file.text" do
      expect(path.file).to eq 'file.txt'
    end
  end
end
