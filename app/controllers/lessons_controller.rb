class LessonsController < ApplicationController
  expose :lessons, -> { Lesson.all }
  expose :lesson do
    Lesson.find_by_slug(params[:id])
  end
  expose :first_level, -> { lesson.levels.first }

end
