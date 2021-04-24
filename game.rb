# coding: utf-8
def animals
  read_file = File.readlines('animals.txt')
  @word = read_file[rand(read_file.length)]
end

def objects
  read_file = File.readlines('objects.txt')
  @word = read_file[rand(read_file.length)]
end

def countrys
  read_file = File.readlines('countrys.txt')
  @word = read_file[rand(read_file.length)]
end

def menu
  puts "Welcome to hangman game!"
  puts "Please choose any option"
  puts "[0] - Animals"
  puts "[1] - Objects"
  puts "[2] - Countrys"
  puts "[3] - Exit"
  option = gets.chomp
end

def start(choice)
  word = choice.chomp
  guesses = 5
  guessed_it = false
  num_letters = (word.length)
  reveal = word.chars
  result = word.chars
  missed_guesses = []
  @history = []
  @guess = ""
  puts "The word contains #{num_letters} letters"
  puts "You have #{guesses} guesses. Good lucky!"
  hidden_letters = reveal.map {|replace| replace = "_"}

  def make_guess
    correct = false
    print "Make a guess: "
    until correct
      guessed = gets.downcase.chomp
      if guessed.to_i != 0 || guessed.length != 1 || guessed == "0"
        puts "An input '#{guessed}' isn't valid!"
        print "\nPlease try again: "
      elsif @history.length > 0
        repeated_char = @history.include?(guessed)
        if repeated_char
          puts "An input '#{guessed}' already guessed!"
          print "\nPlease make another guess: "      
        else
          @history << guessed
          @guess = guessed
          correct = true
        end
      else !repeated_char
        @history << guessed
        @guess = guessed
        correct = true
      end
    end
  end
  
  until guesses == 0 || guessed_it
    puts "*** #{hidden_letters.join(" ")} *** "
    puts "Your guesses: '#{@history.join(' ')}'"
    puts "Your missed guesses: '#{missed_guesses.join(', ')}'"
    self.make_guess
    
    if reveal.include?(@guess)
      repeated_chars = (word.count(@guess) - 1)
      for i in 0..repeated_chars
        index = reveal.find_index(@guess)
        hidden_letters[index] = @guess
        reveal[index] = "0"
      end
      if hidden_letters == result
        puts "*** #{hidden_letters.join(" ")} *** "
        puts "Congratz, you guessed!"
        guessed_it = true
        exit
      end 
    else
      guesses = guesses - 1
      missed_guesses << @guess
      puts "You missed! You have #{guesses} guesses remaining"
    end
  end
  puts "Sorry! You have fail! The word is #{word.upcase}. See you later!"
end

def main
  exit_options = false
  until exit_options
   options = menu
    case options
    when "0"
      puts "Animals"
      exit_options = true
      start(animals)
    when "1"
      start(objects)
      exit_options = true
    when "2"
      start(countrys)
      exit_options = true
    when "3"
      puts "Exiting..."
      exit_options = true
    else
      puts "An option #{options} isn't valid!"
    end
  end
end

main


