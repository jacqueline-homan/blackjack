# Interactive commandline blackjack game

def calculate_total(cards)
  #[["Hearts", "3"], ["Spades", "10"]]
  arr = cards.map{|e| e[1]}

  total = 0
  arr.each do |value| 
    if value.to_i == "A"
      total += 11
    elsif value.to_i ==0
      total += 10
    else
      total += value.to_i      
    end
  end

  arr.select{|e| e == "A"}.count.times do
    total -= 10 if total > 21
  end
  return total
end

#def dealertotal(cards)
#end

#def mytotal(cards)
#end


puts "Welcome to my Blackjack game!"

suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
cards = ['2','3','4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

deck = suits.product(cards)
deck.shuffle!

# Deal the cards

mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

# Show cards
puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of: #{dealertotal}"
puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of: #{mytotal}"
puts ""

# Player's turn


while mytotal < 21
  puts "What do you want to do? Press 1 for Hit or 2 for Stay:"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "Error: You must enter 1 or 2"
    next
  end

  if hit_or_stay == "2"
    puts "You chose to Stay"
    break
  end

# Hit
  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  mycards << new_card 
  mytotal = calculate_total(mycards)
  puts "Your total is now: #{mytotal}" 

  if mytotal == 21
    puts "Congratulations, you hit Blackjack! You win!" 
    exit

  elsif mytotal > 21
    puts "You busted!"
    exit
  end
end

# Dealer's turn
if dealertotal == 21
  puts "Sorry, Dealer hit Blackjack. You lose."
  exit
end

while dealertotal < 17
  #hit
  new_card = deck.pop
  puts "Dealing new card for dealer: #{new_card}"
  dealercards << new_card
  dealertotal = calculate_total(dealercards)
  puts "Dealer total is now: #{dealertotal}"

  if dealertotal == 21
    puts "Dealer hit Blackjack. You lose."
    exit
  elsif dealertotal > 21
    puts "Congratulations, Dealer busted! You win!"
    exit
  end      
end

#Compare hands
puts "Dealer's cards: "
dealercards.each do |card|
  puts "=> #{card}"
end
puts ""
puts "Your cards: "
mycards.each do |card|
  puts "=> #{card}"
end
puts ""

if dealertotal > mytotal
  puts "Sorry, Dealer wins."
elsif dealertotal < mytotal
  puts "Congratulations, you win!"
else
  puts "It's a tie!"
end
exit
