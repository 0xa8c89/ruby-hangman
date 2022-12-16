def get_random_word(words_array)
  word = ''
  word = words_array.sample.chomp until word.length >= 5 && word.length <= 12
  word
end

words = File.open('google-10000-english-no-swears.txt', 'r').readlines

word = get_random_word(words)
unknown = ['_'] * word.length

until word.split('') == unknown
  print 'Enter your guess: '
  input = gets.chomp

  word.split('').each_with_index do |letter, idx|
    unknown[idx] = input if letter == input
  end

  puts unknown.join(' ')
end
