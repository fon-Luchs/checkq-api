class QuestionObserver < ActiveRecord::Observer
  def after_touch(record)
    record.rate = record.rolls_count + (record.success_atempts + 1) / (record.fail_atempts + 1)
    record.save
  end
end
