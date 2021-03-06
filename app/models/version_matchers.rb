class VersionMatchers
  attr_accessor :list

  def initialize str
    if str.is_a? String
      str.strip!
      str = '*' if str.blank?
    end
    @list = str.to_s.split(',').map { |s| VersionMatcher.parse s }
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
