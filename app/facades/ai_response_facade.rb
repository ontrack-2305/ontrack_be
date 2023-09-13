class AiResponseFacade
  def self.fetch_gpt_response(query)
    service = AiService.new
    response = service.fetch_gpt_response(query)
    Breakdown.new(id: response[:id],
                  content: response[:choices][0][:message][:content]
                  )
  end
end