require "minitest/autorun"

class DebugtecaTest < Minitest::Test
  def test_cellular_automaton
    if File.exist?("zoo.txt")
      File.readlines("zoo.txt").map(&:rstrip).each_cons(2) do |pair|
        prev_line = pair[0]
        curr_line = pair[1]

        assert curr_line == (prev_line[-1] + prev_line + prev_line[0]).chars.each_cons(3).map {|*a| 30[a.join.to_i(2)] }.join
      end
    else
      assert true
    end
  end
end
