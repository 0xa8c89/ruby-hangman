def get_random_word(words_array)
  word = ''
  word = words_array.sample.chomp until word.length >= 5 && word.length <= 12
  word
end

words = File.open('google-10000-english-no-swears.txt', 'r').readlines

word = get_random_word(words)