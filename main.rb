# frozen_string_literal: true

require './lib/board'

puts <<-TITLE

 ██████ ██   ██ ███████ ███████ ███████
██      ██   ██ ██      ██      ██
██      ███████ █████   ███████ ███████
██      ██   ██ ██           ██      ██
 ██████ ██   ██ ███████ ███████ ███████

Welcome! this is Command Line Interface (CLI) Implementation of Classic Chess Game using Ruby.

How to play:
1. Input the coordinates of the piece you wish to move, and the coordinates of the target square, without spaces.
Example: 'd2d3', 'h7h5', 'g8f6'
2. To perform a castling move, input the coordinates of the King and the square where the King will land.
Example: 'e1g1', 'e8c8'
3. At any time, Player can save the game by typing 'save'.


g2g3 b8a6 f1h3 c7c6 g1f3 d8b6 e1g1 d7d6 e2e4 c8h3 e4e5 e8c8 e5e6 h7h5 e6f7 h8h7 f7g8
TITLE

puts <<-START
Choose your game:
1. New Game
2. Load Game
START

input = nil
loop do
  input = gets.chomp.downcase
  break if ['1', '2'].include?(input)
  puts 'Invalid input! Type 1 or 2.'
end


if input == '1'

  puts "Enter player white name:"
  shiro = gets.chomp
  puts "Enter player black name:"
  kuro = gets.chomp

  game = Board.new(shiro, kuro)
  if game.play == 'save'
    File.open('./save.data', 'wb') { |f| f.write(Marshal.dump(game)) }
    puts "Game successfully saved to './save.data'."
  end
else
  puts "Game successfully loaded from './save.data'."

  load_game = Marshal.load(File.read('./save.data'))
  load_game.play
end
