defmodule Guess do
  use Application

  def start(_, _) do
    run()
    {:ok, self()}
  end

  # welcome user
  def run() do
    IO.puts("welcome to the guess'game:")

    # select difficulty level
    IO.gets("choose a difficulty level\n1-easy\n2-medium\n3-hard\n")
    |> parse_input()
    |> prepare_game()
    |> play()
  end

  def play(random_number) do
    IO.gets("whats your guess?")
    |> parse_input()
    |> guess(random_number, 1)
  end

  def play(random_number, counter) do
    IO.gets("whats your guess?")
    |> parse_input()
    |> guess(random_number, counter)
  end

  def guess(guess_number, random_number, count) when guess_number > random_number do
    IO.puts('you guess is too high..')
    play(random_number, count + 1)
  end

  def guess(guess_number, random_number, count) when guess_number < random_number do
    IO.puts('you guess is too low..')
    play(random_number, count + 1)
  end

  def guess(_guess_number, _random_number, count) do
    IO.puts('you got it! in #{count} attempt(s)')

    avaliates(count)
  end

  def parse_input({value, _}), do: value

  def parse_input(:error) do
    IO.puts("invalid option, choose again..")
    run()
  end

  def parse_input(dificulty_level) do
    Integer.parse(dificulty_level)
    |> parse_input()
  end

  # generate random nmbr
  def prepare_game(difficulty_level) do
    case difficulty_level do
      1 ->
        Enum.random(1..10)

      2 ->
        Enum.random(1..100)

      3 ->
        Enum.random(1..1000)

      _ ->
        IO.puts("invalid option, choose again..")
        run()
    end
  end

  # avaliates
  def avaliates(count) do
    {_, msg} =
      %{
        (1..1) => "on the fly!",
        (2..4) => "your luck is.. ok.. ",
        (5..10000) => "best luck next time.."
      }
      |> Enum.find(fn {range, _} ->
        Enum.member?(range, count)
      end)

    IO.puts(msg)
  end

  # score
end
