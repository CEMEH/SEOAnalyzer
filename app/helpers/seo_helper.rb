module SeoHelper
  def word_weight(word)
    weight = word.weight
    result = weight.to_s + '%<br/>'

    #@todo: вынести в модуль seo. определять основное контекстное ядро
    if weight >= 2 and weight <= 7
      result += '<span class="label label-success">OK</span>'
    end
    if weight > 7
      result += '<span class="label label-important">SPAM</span>'
    end
    if weight < 2
      result += '<span class="label label-warning">недостаточно</span>'
    end
    result
  end
end
