require 'Seo'
require 'Parser'

class MystemController < ApplicationController
  def index
    if params[:code].present?
      words = Parser::parse_html(params[:code])
      @result = Seo::Page.new(words)
    end
  end
end
