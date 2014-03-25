require 'formula'
require 'find'
require 'fileutils'

def copy_without(source_path, target_path, exclude)
  Find.find(source_path) do |source|
    target = source.sub(/^#{source_path}/, target_path)
    if File.directory? source
      Find.prune if File.basename(source) == exclude
      FileUtils.mkdir target unless File.exists? target
    else
      FileUtils.copy source, target
    end
  end
end

class Zork3 < Formula
  homepage 'http://www.infocom-if.org/downloads/downloads.html'
  url 'http://www.infocom-if.org/downloads/zork3.zip'
  version '1'
  sha1 '66fe2ac86b5b53406a272b75be3bb0e34c894fff'

  depends_on 'jzip'

  def install
    FileUtils.makedirs("./share/zork3")
    copy_without('.', './share/zork3', 'share')
    file = File.new("zork3", "w+", 0755)
    file.write "#!/bin/bash
jzip #{prefix}/share/zork3/DATA/ZORK3.DAT
"
    bin.install "zork3"
    share.install "share/zork3"
  end
end
