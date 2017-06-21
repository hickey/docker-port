require 'spec_helper'

describe Semi::Variables::Boolean do

  [
    # test value,  real value
    [true,         true],
    [false,        false],
    ['true',       true],
    ['yes',        true],
    ['on',         true],
    ['enable',     true],
    ['false',      false],
    ['no',         false],
    ['off',        false],
    ['disable',    false]
  ].each do |test|
    it "set '#{test[0]}' as #{test[1]}" do
      expect(Semi::Variables::Boolean.new(test[0]).value).to eq test[1]
    end
  end

  [
    # test value,  exception?
    ['true',       'not raise'],
    ['false',      'not raise'],
    ['foo',        'raise'],
    ['bar',        'raise'],
    ['1',          'raise'],
    ['0',          'raise'],
    [1,            'raise'],
    [0,            'raise'],
    [nil,          'raise']
  ].each do |test|
    it "set '#{test[0]}' to #{test[1]} exception" do
      if test[1] == 'raise'
        expect{Semi::Variables::Boolean.new(test[0])}.to raise_error(Semi::VariableError)
      else
        expect{Semi::Variables::Boolean.new(test[0])}.not_to raise_error
      end
    end
  end

  ##
  # Test variable specific output methods
  let (:on)  {Semi::Variables::Boolean.new('true')}
  let (:off) {Semi::Variables::Boolean.new('false')}

  it "#onoff returns 'on'" do
    expect(on.onoff).to eq 'on'
  end

  it "#ONOFF returns 'ON'" do
    expect(on.ONOFF).to eq 'ON'
  end

  it "#OnOff returns 'On'" do
    expect(on.OnOff).to eq 'On'
  end

  it "#onoff returns 'off'" do
    expect(off.onoff).to eq 'off'
  end

  it "#ONOFF returns 'OFF'" do
    expect(off.ONOFF).to eq 'OFF'
  end

  it "#OnOff returns 'Off'" do
    expect(off.OnOff).to eq 'Off'
  end

  it "#yesno returns 'yes'" do
    expect(on.yesno).to eq 'yes'
  end

  it "#YESNO returns 'YES'" do
    expect(on.YESNO).to eq 'YES'
  end

  it "#YesNo returns 'Yes'" do
    expect(on.YesNo).to eq 'Yes'
  end

  it "#yesno returns 'no'" do
    expect(off.yesno).to eq 'no'
  end

  it "#YESNO returns 'NO'" do
    expect(off.YESNO).to eq 'NO'
  end

  it "#YesNo returns 'No'" do
    expect(off.YesNo).to eq 'No'
  end

  it "#enabledisable returns 'enable'" do
    expect(on.enabledisable).to eq 'enable'
  end
  
  it "#ENABLEDISABLE returns 'ENABLE'" do
    expect(on.ENABLEDISABLE).to eq 'ENABLE'
  end

  it "#EnableDisable returns 'Enable'" do
    expect(on.EnableDisable).to eq 'Enable'
  end

  it "#enabledisable returns 'disable'" do
    expect(off.enabledisable).to eq 'disable'
  end
  
  it "#ENABLEDISABLE returns 'DISABLE'" do
    expect(off.ENABLEDISABLE).to eq 'DISABLE'
  end

  it "#EnableDisable returns 'Disable'" do
    expect(off.EnableDisable).to eq 'Disable'
  end

  it "#truefalse returns 'true'" do
    expect(on.truefalse).to eq 'true'
  end

  it "#TRUEFALSE returns 'TRUE'" do
    expect(on.TRUEFALSE).to eq 'TRUE'
  end

  it "#TrueFalse returns 'True'" do
    expect(on.TrueFalse).to eq 'True'
  end

  it "#truefalse returns 'false'" do
    expect(off.truefalse).to eq 'false'
  end

  it "#TRUEFALSE returns 'FALSE'" do
    expect(off.TRUEFALSE).to eq 'FALSE'
  end

  it "#TrueFalse returns 'False'" do
    expect(off.TrueFalse).to eq 'False'
  end

end