class Answer::Result
  include ActiveModel::Validations

  def initialize(args = {})
    args ||= {}

    @result = args[:result]
  end

  validate do |model|
    model.errors.add :answer_result, 'have invalid options' if answers.any?(&:nil?) || questions.any?(&:nil?)
  end

  def save
    return false unless valid?

    results && true
  end

  def to_json(*args)
    find_results.map do |a|
      a.decorate.to_json
    end
  end

  private

  def results
    analitic && find_results
  end

  def find_results
    @results ||= Answer::AnswerChecker.check @result
    @results
  end

  def analitic
    Answer::AnalystCollection.collect @result
  end

  def answers
    @answers ||= []
    @result.each { |e| @answers << Answer.find_by(id: e[:answer_id]) } if @answers.size.zero?
    @answers
  end

  def questions
    @questions ||= []
    @result.each { |e| @questions << Question.find_by(id: e[:id]) } if @questions.size.zero?
    @questions
  end
end
