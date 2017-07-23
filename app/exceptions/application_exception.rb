class ApplicationException < StandardError
  def code
    422
  end

  def name
    self.class.name.demodulize
  end

  def reason
    'No reason available.'
  end
end
