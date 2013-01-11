# -*- coding: utf-8 -*-
# ValueObject
class VersionMatcher
  Matchers = {'=' => :eql,
              '>' => :more,
              '>=' => :more_or_eql,
              '!' => :not_eql,
              '-' => :range}

  attr_accessor :version1, :version2, :matcher

  def self.parse str
    str.strip!
    if /^(=|>|>=|!|)([0-9\.]+)$/.match str
      new $1, $2
    elsif /([0-9\.]+)\-([0-9\.]+)/.match str
      new '-', $1, $2
    else
      raise "Неизвестный формат матчера версий '#{str}'"
    end
  end

  def initialize matcher, version1, version2=nil
    matcher = '=' if matcher.blank?
    raise "Unknown matcher #{matcher}" unless Matchers.has_key? matcher
    @matcher, @version1 = matcher, Version.new(version1)
    if @matcher == '-'
      raise "No second version number in range" if !version2.present?
      @version2 = Version.new version2

      raise "Second version must be more than first" unless version2>version1
    end
  end

  def to_s
    if matcher == '='
      version1.to_s
    elsif matcher == '-'
      version1.to_s + '-' + version2.to_s
    else
      matcher + version1.to_s
    end
  end

  def =~ version
    version = Version.new version unless version.is_a? Version
    send Matchers[matcher], version
  end

  def eql version
    version1 == version
  end

  def more version
    version > version1
  end

  def more_or_eql version
    version >= version1
  end

  def not_eql version
    version1 != version
  end

  def range version
    version1 <= version and version <= version2
  end

end
