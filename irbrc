# IRB.conf[:AUTO_INDENT] = true
require 'irb/completion'
begin
  require 'irb/ext/save-history'
rescue LoadError
end
require 'pp'

IRB.conf[:SAVE_HISTORY] = 1000
if ENV['PWD'].index('/webdev/')
  IRB.conf[:HISTORY_FILE] = "#{ENV['PWD']}/.irb_history"
else
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
end
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:USE_AUTOCOMPLETE] = false
IRB.conf[:USE_MULTILINE] = false

Object.class_eval do
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end
end

def time(times = 1)
  require 'benchmark' unless defined?(Benchmark)
  Benchmark::realtime { yield }
end

def pbcopy(data)
  File.popen('pbcopy', 'w') { |p| p << data.to_s }
  $?.success?
end

def copy_history
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  copy content
end

begin
  require 'big_decimal'
rescue LoadError
  require 'bigdecimal'
end

BigDecimal.class_eval do
  def inspect
    to_s("F")
  end
end

load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']
