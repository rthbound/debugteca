# Adapted from script authored by D.E. Akers 
# Original script: https://eval.in/498526
class ECA
  def initialize rule, width, height
    @rule, @width, @height = rule, width, height

    @grid = []
    @line = [0] * width
    @line[width / 2] = 1
    @monkey_wrench = rand(height)

    system "git reset --hard $(git rev-list --max-parents=0 --abbrev-commit HEAD)"
  end

  def step(counter)
    @line = ([@line[-1]] + @line + [@line[0]]).each_cons(3).map { |*a|
      @rule[a.join.to_i(2)]
    }
    if counter == @monkey_wrench
      @grid.concat @line.reverse!
    else
      @grid.concat @line
    end

    system "echo #{@line.join} >> zoo.txt"
    system "git add zoo.txt; git commit -m '#{@line.join}'", out: File::NULL
  end

  def run
    @height.times { |counter| step(counter) }
  end
end

ECA.new(30, 500, 500).tap(&:run)
