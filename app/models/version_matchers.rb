class VersionMatchers
  attr_accessor :list

  def initialize str
    @list = str.split(',').map { |s| VersionMatcher.parse s }
  end

  def to_s
    @list.join(', ')
  end

  def match version
    @list.each do |m|
      return true if m =~ version
    end
    return false
  end

end
