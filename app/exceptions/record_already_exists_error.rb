class RecordAlreadyExistsError < StandardError

  def initialize(msg)
    super(msg)
  end

end