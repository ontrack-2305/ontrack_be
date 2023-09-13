class Breakdown
  attr_reader :content, :id

  def initialize(data)
    @content = data[:content]
    @id = data[:id]
  end
end