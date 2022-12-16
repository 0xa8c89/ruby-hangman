require 'json'

# TODO; Finish exc 6 and classify this spaghetti

def get_random_word(words_array)
  word = ''
  word = words_array.sample.chomp until word.length >= 5 && word.length <= 12
  word.downcase
end

def save_file(word, unknown, right_guesses, wrong_guesses)
  hash = {
    'word' => word,
    'unknown' => unknown,
    'right_guesses' => right_guesses,
    'wrong_guesses' => wrong_guesses
  }
  File.open('save.json', 'w') { |f| f.write(JSON.dump(hash)) }
end

def load_from_file
  JSON.parse(File.read('save.json'))
end

words = File.open('google-10000-english-no-swears.txt', 'r').readlines

word = get_random_word(words)
unknown = ['_'] * word.length

right_guesses = []
wrong_guesses = []

print 'Do you want to continue game from save? (y/n) '
continue_input = gets.chomp.downcase
if continue_input == 'y' || continue_input == 'yes'
  save = load_from_file
  word = save['word']
  unknown = save['unknown']
  right_guesses = save['right_guesses']
  wrong_guesses = save['wrong_guesses']
end

until word.split('') == unknown
  print 'Enter your guess: '
  input = gets.chomp.downcase
  while wrong_guesses.include?(input) || right_guesses.include?(input)
    puts "Letter '#{input}' has already been tried. Try again."
    print 'Enter your guess: '
    input = gets.chomp.downcase
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

  print 'Do you want to save progress and quit? (y/n) '
  save_input = gets.chomp.downcase
  if save_input == 'y' || save_input == 'yes'
    save_file(word, unknown, right_guesses, wrong_guesses)
    break
  end
end
