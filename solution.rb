require_relative 'wl'

def word_ladder_neighbours(word)
    patterns = []
    for i in 0..3
        tmp = word.dup
        tmp[i] = "."
        patterns << tmp
    end
    result = FOUR_LETTER_WORDS.select{ |w|
        w != word && (w.match(patterns[0]) || w.match(patterns[1]) || w.match(patterns[2]) || w.match(patterns[3]))
    }
    result
end

def find_word_with_n_neighbours(n)
    result = FOUR_LETTER_WORDS.select{|w|
        word_ladder_neighbours(w).size == n
    }
    result
end

def find_words_n_degrees_away(word, n)
    result = []
    tmp = []
    tmp2 = []
    tmp = word_ladder_neighbours(word)
    tmp.each{|w| result << w}
    for i in 2..n
        tmp.each{|w| (tmp2 << word_ladder_neighbours(w)).flatten!}
        tmp2.each{|w| result << w}
        tmp = tmp2.dup
        tmp2 = []
    end
    result.uniq
end

# print word_ladder_neighbours("pall")
puts find_word_with_n_neighbours(33) # the word is care
# print find_words_n_degrees_away("aloe", 3)