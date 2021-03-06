
class Light

  def initialize(avatar,hash)
    @avatar,@hash = avatar,hash
  end

  attr_reader :avatar

  def colour
    # old katas used 'outcome'
    (@hash['colour'] || @hash['outcome']).to_sym
  end

  def time
    Time.mktime(*@hash['time'])
  end

  def number
    @hash['number'].to_i
  end

end
