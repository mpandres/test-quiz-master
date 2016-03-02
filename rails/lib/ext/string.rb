class String

  def simplify
    self.gsub(/\s+/, " ").strip.downcase
  end

  def to_word
    if self.to_i.to_s == self
      return self.to_i.humanize
    end

    return self
  end

end
