class Answer::Result
  include ActiveModel::Validations

  def initialize(args = {})
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
    decorated_result.to_json
  end

  private

  def results
    analitic && find_results
  end

  def decorated_result
    @arr_result = []
    find_results.map do |a|
      @arr_result << a.decorate
    end
    @arr_result
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
    @result.each do |e|
      next if e[:answer_id].nil?

      @answers << Answer.find_by(id: e[:answer_id]) if @answers.size.zero?
    end
    @answers
  end

  def questions
    @questions ||= []
    @result.each { |e| @questions << Question.find_by(id: e[:id]) } if @questions.size.zero?
    @questions
  end
end
