class DateSerializer
  include FastJsonapi::ObjectSerializer

  attributes :best_day do |object|
    object.best_day = object.best_day.strftime("%F")
  end
end
