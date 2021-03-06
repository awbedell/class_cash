class Period < ActiveRecord::Base
  has_many :students, dependent: :destroy
  has_many :behaviors, through: :student
  has_many :bonuses, dependent: :destroy
  belongs_to :instructor
  accepts_nested_attributes_for :students, reject_if: proc { |attributes| attributes['email'].blank? }

  validates :students, presence: true

  def find_richest
    self.students.update_all(richest: false)
    if self.students.count == 1
      return
    elsif self.students.reorder(:cash).reverse.first.cash == self.students.reorder(:cash).reverse.second.cash
      return
    else
      rich = self.students.reorder(:cash).last
      rich.update(richest: true)
      if Award.where(student_id: rich.id).where(award_type_id: 1).count == 0
        Award.create(student_id: rich.id, award_type_id: 1,
            reason: "being the richest", payment: 100)
      end
    end
  end

  def pay_students
    @students = Student.where(period_id: self.id).all
    transaction do
      @students.each do |student|
        a = Behavior.where(date: Date.today, student_id: student.id).first
        if a && a.well_behaved
          student.update(cash: (student.cash + self.payscale))
        end
        student.jobs.each do |job|
          if job.last_date_done == Date.today
            student.update(cash: (student.cash + job.payscale))
          end
        end
      end
    end
  end

  def class_average
    students = Student.where(period_id: self.id).all
    total = students.sum(:cash)
    if students.length > 0
      (total / students.length) + (average_adjust || 0)
    else
      0
    end
  end

  def extra_slots
    up_to = 30 - students.count
    up_to = 1 if up_to < 1
    up_to
  end

end
