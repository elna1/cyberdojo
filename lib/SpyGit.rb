
class SpyGit

  def initialize
    @log = { }
    @stub = { }
  end

  def log
    @log
  end

  def init(dir, options)
    record(dir, 'init', options)
  end

  def add(dir, what)
    record(dir, 'add', what)
  end

  def rm(dir, what)
    record(dir, 'rm', what)
  end

  def commit(dir, options)
    record(dir, 'commit', options)
  end

  def tag(dir, options)
    record(dir, 'commit', options)
  end

  def show(dir, options)
    record(dir, 'show', options)
    stub(dir,'show',options)
  end

  def diff(dir, options)
    record(dir, 'diff', options)
  end

  def spy(dir, command, options, stub)
    tuple = [dir,command,options]
    @stub[tuple] = stub
  end

private

  def record(dir, command, options)
    @log[dir] ||= [ ]
    @log[dir] << [command, options]
    "{:hack=>'yes'}"
  end

  def stub(dir, command, options)
    tuple = [dir,command,options]
    @stub[tuple]
  end

end
