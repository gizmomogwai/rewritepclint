require 'rewritepclint/version'
require 'nokogiri'

module Rewritepclint
  def rewrite(file)
    doc = Nokogiri::XML(file)
    files = doc.xpath("//file")
    prefix = Dir.cwd.split("/").last
    puts prefix
    files.each do |f|
      f.content = File.join(prefix, e.content)
    end
    return doc.to_xml()
  end
end
