class StudentPresenter < Struct.new(:student)

  def full_name
    student.first_name + " " + student.last_name
  end

  def sped
    if student.sped.nil?
      "N/A"
    else
      student.sped ? "Yes" : "No"
    end
  end

  def limited_english_proficient
    if student.limited_english_proficient.nil?
      "N/A"
    else
      student.limited_english_proficient ? "Yes" : "No"
    end 
  end
end