require_relative 'wl'
require 'json'

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

def process_data_once
    tmp = {}
    FOUR_LETTER_WORDS.each{|w|
        tmp[w] = word_ladder_neighbours(w)
    }
    File.open("./result.json", "w") do |f|
        f.write(JSON.pretty_generate(tmp))
    end
end

def find_word_with_n_neighbours(n)
    if !File.file?("result.json")
        puts "Processing data"
        process_data_once
    end
    puts "Reading stuff from file now"
    data = JSON.parse(File.read("./result.json"))
    data.select{ |key, value| value.size == n}.keys
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