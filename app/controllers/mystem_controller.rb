require 'Seo'
require 'Parser'

class MystemController < ApplicationController
  def index

    @code = nil
    if params[:code].present?

      @code = params[:code]
      words = Parser::parse_html(params[:code])
      @result = Seo::Page.new(words)
      puts @result
    end
  end
end
