module UsersHelper
  # This will divide into log scale. E.g. 1-2-4-8-16-32
  # The current problem is it can go below zero
  def self.user_twins_by_level2(level)
    first_step = 0.01
    multiplier = 2

    mx = best_user_twins.percent

    if level == 1 then
      user_twins.where('percent > ?', mx-first_step)
    else
      step = first_step
      gap = 0
      for x in 1...level
        gap += step
        step *= multiplier
      end

      range = mx-gap-step..mx-gap
      user_twins.where(:percent => range)
    end
  end

    # This method evenly splits range upto your best twin
  def self.user_twins_by_level(level, set, max_percent, params = {})
    level = level.to_i
    max_levels = 5
    max_levels = params[:max_levels].to_i if params[:max_levels]
    max_percent = max_percent.to_f


    return if level <= 0 or level > max_levels
    return if max_percent <= 0

    first_is_double = false

#    max_levels -= 1 if not first_is_double
    x = max_percent / (2 ** max_levels + 1)

    if first_is_double then
      if level == 1 then
        set.where('percent > ?', max_percent-x*2)
      elsif level >= max_levels then
        set.where('percent < ?', max_percent-((2 ** (level-1))*x))
      else
        min = 2 ** (level -1)
        max = 2 ** (level)

        set.where("user_twins.percent between ? and ?",
                  max_percent - (max * x), max_percent - (min * x))
      end
    else
      level -= 1

      if level == 0 then
        set.where('percent > ?', max_percent-x)
      elsif level >= max_levels then
        set.where('percent < ?', max_percent-((2 ** (level-1))*x))
      else
        min = 2 ** (level - 1)
        max = 2 ** (level)

        set.where("user_twins.percent between ? and ?",
                  max_percent - (max * x), max_percent - (min * x))
      end
    end
  end

end
