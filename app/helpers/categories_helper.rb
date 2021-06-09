module CategoriesHelper
  def category_options_for_select(collection = Category.all.order(title: :asc))
    collection.map do |country|
      [
        country.title,
        country.id,
      ]
    end
  end

  def color_options_for_select()
    ["black", "red", "yellow", "green", "blue"].map do |color|
      [
        color,
        color,
        {
          class: "color-#{color}"
        }
      ]
    end
  end
end
