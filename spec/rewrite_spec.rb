require 'rewritepclint'

describe Rewritepclint do
  it 'should replace the files array with a prefixed version' do
    original = <<-eos
<?xml version="1.0"?>
<doc>
<message><file>test\\test.cpp</file> <line>8</line> <type>Info</type> <code>715</code> <desc>Symbol 'argc' (line 6) not referenced</desc></message>
<message><file>test\\test.cpp</file> <line>6</line> <type>Info</type> <code>830</code> <desc>Location cited in prior message</desc></message>
<message><file>test\\test.cpp</file> <line>8</line> <type>Info</type> <code>715</code> <desc>Symbol 'args' (line 6) not referenced</desc></message>
</doc>
eos
    should_be_plist = <<-eos
<?xml version="1.0"?>
<doc>
<message><file>prefix/test/test.cpp</file> <line>8</line> <type>Info</type> <code>715</code> <desc>Symbol 'argc' (line 6) not referenced</desc></message>
<message><file>prefix/test/test.cpp</file> <line>6</line> <type>Info</type> <code>830</code> <desc>Location cited in prior message</desc></message>
<message><file>prefix/test/test.cpp</file> <line>8</line> <type>Info</type> <code>715</code> <desc>Symbol 'args' (line 6) not referenced</desc></message>
</doc>
eos
    new_content = Rewritepclint.with(prefix: 'prefix', content: original)
    new_content.should eq(should_be_plist)
  end
end
