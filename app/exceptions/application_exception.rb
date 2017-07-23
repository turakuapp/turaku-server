class ApplicationException < StandardError
  def name
    self.class.name.demodulize
  end

  def reason
    'No reason available.'
  end
end
