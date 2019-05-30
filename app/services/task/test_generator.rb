class Task::TestGenerator
  def initialize(args = {})
    args ||= {}

    @subject_ids = args[:subject_ids]

    @question_count = args[:question_count]
  end

  def save
    # false unless valid?

    subjects && true
  end

  def to_json(*args)
    question_parser.to_json
  end

  private

  def question_parser
    increment = 0
    count = 0
    loop do
      if (@question_count % (@subject_ids.size + increment)).zero?
        count = @question_count / (@subject_ids.size + increment)
        break
      end
      increment += 1
    end

    subjects.map do |subject|
      subject.questions.order(rate: :asc).first(100).map do |question|
        question.decorate.as_json
      end
    end
  end

  def subjects
    @subjects ||= []
    @subject_ids.each { |id| @subjects << Subject.find(id) } if @subjects.size.zero?
    @subjects
  end
end
