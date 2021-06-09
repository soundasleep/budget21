module CategoriesHelper
  def category_options_for_select(collection = Category.all.order(title: :asc))
    collection.map do |country|
      [
        country.title,
        country.id,
      ]
    end
  end
end
