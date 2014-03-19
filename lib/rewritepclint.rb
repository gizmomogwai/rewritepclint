require 'rewritepclint/version'
#require 'nokogiri'

module Rewritepclint
#  def self.with(prefix: prefix, content: content)
#    doc = Nokogiri::XML(content)
#    files = doc.xpath("//file")
#    files.each do |f|
#      f.content = File.join(prefix, f.content).gsub("\\", "/")
#    end
#    return doc.to_xml()
#  end
  def self.with(prefix: prefix, content: content)
    content = content.gsub('err:menubuilder:init_xdg error looking up the desktop directory', '')
    match = content.match(Regexp.new(".*(<.xml.*</doc>.).*", Regexp::MULTILINE))
    content = match[1]
    content = content.gsub(Regexp.new("<file>(.*?)</file>")) do |match|
      new_filename = $1.gsub("\\", "/")
      "<file>#{File.join(prefix, new_filename)}</file>"
    end
  end
  def self.files_with_prefix_current_directory()
    Dir.glob('**/lint.xml').each do |file|
      prefix = Dir.pwd.split('/').last
      newfile = Rewritepclint::with(prefix: prefix, content: File.read(file))
      File.open(file, 'w') do |io|
        io.write(newfile)
      end
    end
  end
end
