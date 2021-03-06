class Right < ActiveRecord::Base
  belongs_to :instructor
  has_many :student_right_assignments, dependent: :destroy
  has_many :students, through: :student_right_assignments

  def available_students(id)
    if !self.instructor_id.nil?
      self.students
    else
      instructor = Instructor.find(id)
      instructor.students.select { |s| s.rights.include? self }
    end
  end
end
