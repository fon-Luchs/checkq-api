class Task::TestGenerator
  include ActiveModel::Validations

  def initialize(args = {})
    args ||= {}

    @subject_ids = args[:subject_ids]

    @question_count = args[:question_count].to_i
  end

  validate do |model|
    model.errors.add :question_count, 'is invalid' if invalid_question_count?

    model.errors.add :subject, 'is not found in this life' if subjects.any?(&:nil?)
  end

  def save
    return false unless valid?

    subjects && true
  end

  def to_json(*args)
    question_parser.to_json
  end

  private

  def question_parser
    Task::QuestionParser.parse(@question_count, subjects)
  end

  def subjects
    @subjects ||= []
    @subject_ids.each { |id| @subjects << Subject.find_by(id: id) } if @subjects.size.zero?
    @subjects
  end

  def invalid_question_count?
    @question_count < @subject_ids.size || @question_count >= 60
  end
end
