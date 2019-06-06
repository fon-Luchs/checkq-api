class Task::QuestionParser
  COEF_CORELATION = 10.freeze

  def self.parse(element_count, arr)
    questions(element_count, arr).shuffle
  end

  def self.questions(element_count, arr)
    count = element_count / arr.size
    corl = 0
    questions = []

    calculate_questions_list(
      target_array: arr, question_array: questions,
      element_count: element_count, count: count, corl: corl
    )

    questions
  end

  def self.calculate_questions_list(args = {})
    args[:target_array].each_with_index.map do |element, index|
      args[:corl] = args[:element_count] - args[:count] * args[:target_array].size if index == args[:target_array].size - 1

      generate_questions_list(
        element: element, count: args[:count],
        corl: args[:corl], question_array: args[:question_array]
      )
    end
  end

  def self.generate_questions_list(args = {})
    span_array = []

    args[:element].questions.order(rate: :asc).first(args[:count] + args[:corl] + COEF_CORELATION).map do |question|
      span_array << question.decorate.as_json
    end

    formation_question_list(
      span_arr: span_array, question_array: args[:question_array],
      count: args[:count], corl: args[:corl]
    )
  end

  def self.formation_question_list(args = {})
    limit = args[:count] + args[:corl]

    args[:span_arr].shuffle[0...limit].each do |question|
      args[:question_array] << question
    end
  end

  private_class_method :questions, :calculate_questions_list,
                       :generate_questions_list,
                       :formation_question_list
end
