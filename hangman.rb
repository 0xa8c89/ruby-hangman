def get_random_word(words_array)
  word = ''
  word = words_array.sample.chomp until word.length >= 5 && word.length <= 12
  word.downcase
end

words = File.open('google-10000-english-no-swears.txt', 'r').readlines

word = get_random_word(words)
unknown = ['_'] * word.length

right_guesses = []
wrong_guesses = []

until word.split('') == unknown
  print 'Enter your guess: '
  input = gets.chomp.downcase
  if wrong_guesses.include?(input) || right_guesses.include?(input)
    puts "Letter '#{input}' has already been tried. Try again."
    next
  end

  word.split('').each_with_index do |letter, idx|
    unknown[idx] = input if letter == input
  end
  word.include?(input) ? right_guesses << input : wrong_guesses << input

  puts "#{wrong_guesses.length} wrong guesses - #{wrong_guesses.join(', ')}"
  puts "#{right_guesses.length} correct guesses - #{right_guesses.join(', ')}"
  puts unknown.join(' ')

  if wrong_guesses.length == 7
    puts "You lost! The word was \"#{word}\""
    break
  end
  if word.split('') == unknown
    puts 'You won!'
    break
  end
end
