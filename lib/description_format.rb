module DescriptionFormat

  private

  def formatted_description_for(child_model)
    description = []
    description << child_model.map(&:description)
    description.join(" and ")
  end
end