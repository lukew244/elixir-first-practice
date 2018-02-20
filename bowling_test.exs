ExUnit.start()

defmodule AssertionTest do
  use ExUnit.Case, async: true

  test 'returns 3 if given a 3 on the first ball' do
    assert Bowling.knock_pins(3) == 3
  end

  test 'should fail if greater than 10' do
    assert_raise RuntimeError, fn ->
      Bowling.knock_pins(12)
    end
  end

  test 'should fail if less than 0' do
    assert_raise RuntimeError, fn ->
      Bowling.knock_pins(-1)
    end
  end

  test 'a regular frame should be the sum of the knocked pins' do
    assert Bowling.frame([roll_one: 2, roll_two: 4]) == 6
  end

  test 'a frame cannot knock more than 10 pins' do
    assert_raise RuntimeError, fn ->
      Bowling.frame([roll_one: 4, roll_two: 10])
    end
  end

  test 'a game of two regular frames should return the sum of scores' do
    assert Bowling.game([[roll_one: 2, roll_two: 4], [roll_one: 3, roll_two: 4]]) == 13
  end
end


defmodule Bowling do
  def knock_pins(pins) when pins >= 0 and pins <= 10 do
    pins
  end

  def knock_pins(_pins) do
    raise "The number of pins should be between 0 and 10"
  end

  def validate_frame(total) when total >= 0 and total <= 10 do
    total
  end

  def validate_frame(_total) do
    raise "The total of pins knocked in a frame should be between 0 and 10"
  end

  def frame(rolls) do
    validate_frame(knock_pins(rolls[:roll_one]) + knock_pins(rolls[:roll_two]))
  end

  def game(frames) do
    frames
    |> Enum.map(fn(rolls) -> frame(rolls) end)
    |> Enum.reduce(0, fn(frame_score, current_game_score) ->
      frame_score + current_game_score
    end)
  end
end
