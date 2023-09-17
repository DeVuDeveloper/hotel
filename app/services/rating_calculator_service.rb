class RatingCalculatorService
  def self.calculate_average_rating(reviews)
    total_rating = 0
    count = reviews.count

    return 0 if count == 0

    reviews.each do |review|
      total_rating += review.rating
    end

    average_rating = total_rating / count.to_f
    average_rating.round(2)
  end
end
