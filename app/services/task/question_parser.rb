class Task::QuestionParser
  def self.parse(element_count, arr)
    questions = questions(element_count, arr)
    questions.flatten!.sort_by! { |hsh| hsh[:rate] }.reverse!
    questions
  end

  def self.questions(element_count, arr)
    count = element_count / arr.size
    corl = 0
    questions = arr.each_with_index.map do |element, index|
      corl = element_count - count * arr.size if index == arr.size - 1
      element.questions.order(rate: :asc).first(count + corl).map do |question|
        question.decorate.as_json
      end
    end
    questions
  end

  private_class_method :questions
end
