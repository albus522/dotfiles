root = ARGV.empty? ? File.expand_path(Dir.pwd) : ARGV.first
submodules = File.read(File.join(root, '.gitmodules')).split(/\n/).map {|s| m = /\[submodule "([^"]+)"\]/.match(s); m ? m[1] : nil }.compact
submodules.each do |s|
  Dir.chdir(File.join(root,s))
  puts "\e[33m#{s}\e[0m"
  puts `git status`
  puts
end