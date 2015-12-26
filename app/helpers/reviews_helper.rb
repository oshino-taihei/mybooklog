module ReviewsHelper
  def rank_star(review)
    if review[:rank] == 0
      return ""
    else
      return review.rank + "☆" * (5 - review[:rank])
    end
  end
end
