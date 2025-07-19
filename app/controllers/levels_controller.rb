class LevelsController < ApplicationController
  expose :lesson, -> { Lesson.find_by_slug(params[:lesson_id]) }
  expose :levels, -> { lesson.levels }
  expose :level do
    levels.find_by_slug(params[:id])
  end
  expose :commands, -> { level.commands }
  expose :command, -> { commands.first }
  expose :next_level, -> { level.next_level }

  def show
    commands = current_user.commands_remaining_for_level(level)

    if commands.empty?
      congrats
    else
      @command = commands.first
    end
  end

  def congrats
    @show_congrats = true
    render :show
  end

  def restart
    current_user.commands.delete(current_user.commands.where(level: level))
    redirect_to lesson_level_path(lesson, level)
  end

end
