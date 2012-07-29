module SeoHelper

  def wordmark_fontsize(word)
    mark = word.mark
    (mark * 0.6).to_i
  end
end
