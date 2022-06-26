class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def normalize (letter)
    case letter
    when "Ё" then "Е"
    when "Й" then "И"
    else letter
    end
  end

  def errors
    normalize_letters = @letters.map { |let| normalize(let) }
    @user_guesses - @letters - normalize_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(normalize(letter))
          letter
        end
      end
    result
  end

  def lost?
    errors_allowed == 0
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    if !over? && !@user_guesses.include?(normalize(letter))
      @user_guesses << normalize(letter)
    end
  end

  def won?
    (@letters.map { |let| normalize(let) } - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end
