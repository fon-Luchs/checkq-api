class DataBase::Seeder
  def self.seed
    build_seed
  end

  def self.build_seed
    subjects = []
    feel subjects
    relation_builder subjects
  end

  def self.feel(arr)
    arr << Subject::AigParsedJson.as_json

    arr << Subject::DatabaseParsedJson.as_json

    arr << Subject::DiffurParsedJson.as_json

    arr << Subject::EvmParsedJson.as_json

    arr << Subject::MethodParsedJson.as_json

    arr << Subject::DiscretParsedJson.as_json

    arr << Subject::MathAnalParsedJson.as_json

    arr << Subject::ProgParsedJson.as_json

    arr << Subject::TerverParsedJson.as_json
  end

  def self.relation_builder(subject_arr)
    subject_arr.map do |s|
      subject = Subject.create! name: s[:subject]
      s[:questions].map do |q|
        question = subject.questions.create! name: q[:question]
        q[:answers].each_with_index.map do |a, index|
          answer = question.answers.create! name: a[:title]
          QuestionAnswer.create answer: answer, question: question if index.zero? && q[:checked]
        end
      end
    end
  end

  private_class_method :build_seed, :feel, :relation_builder
end
