require 'Mystem'

class MystemController < ApplicationController
  def index

    @test = Mystem.test
  end
end
