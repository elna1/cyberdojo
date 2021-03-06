
me = File.expand_path(File.dirname(__FILE__))
CYBERDOJO_HOME_DIR = File.expand_path('..', me) + '/'

$LOAD_PATH << CYBERDOJO_HOME_DIR + 'lib'
$LOAD_PATH << CYBERDOJO_HOME_DIR + 'app/lib'
$LOAD_PATH << CYBERDOJO_HOME_DIR + 'app/models'

require 'OsDisk'
require 'OsDir'
require 'Git'
require 'DockerTestRunner'
require 'Dojo'
require 'DummyTestRunner'
require 'Languages'
require 'Language'
require 'Exercises'
require 'Exercise'
require 'Katas'
require 'Kata'
require 'Avatars'
require 'Avatar'
require 'Sandbox'
require 'Lights'
require 'Light'
require 'Id'
require 'json'

def create_dojo
  externals = {
    :disk => OsDisk.new,
    :git => Git.new,
    :runner => DummyTestRunner.new
  }
  Dojo.new(CYBERDOJO_HOME_DIR,'json',externals)
end

def number(value,width)
  spaces = ' ' * (width - value.to_s.length)
  "#{spaces}#{value.to_s}"
end

def dots(dot_count)
  dots = '.' * (dot_count % 32)
  spaces = ' ' * (32 - dot_count%32)
  dots + spaces + number(dot_count,5)
end
