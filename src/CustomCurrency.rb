require 'bigdecimal'
require 'pry'
class CustomCurrency

  def initialize(types)
      @TypesOfChange = stringToCurrencies(types)
      all_possible_combos()
  end

  def stringToCurrencies(string)
      temp = string.split(',')
      output = {}

      temp.each_with_index do |element,index|
        if index.even?
          output[element] = BigDecimal("0")
        else
          output[temp[index - 1]] = 100 / BigDecimal(element)
        end
      end

      return output

  end

  def all_possible_combos()
    @combos = 0
    @runs = 0
    number_of_coins = {}
    @TypesOfChange.keys.each do |element|
      number_of_coins[element] = 0
    end

    sortedCoins = @TypesOfChange.sort_by{|name,unitValue| unitValue}.reverse

    names =  sortedCoins.map{|element| element[0]}
    output = names.map{|element| "%10s" %element}.join("")
    puts output
    coin_iteration(number_of_coins,sortedCoins,0)

    puts ""
    puts "Count:  #{@combos}"

  end


  def coin_iteration(coins,sortedCoins,index)
    #Recursive..
    coins[sortedCoins[index][0]] = 0
    coin_max = max_coins(units_left(units(coins)))[sortedCoins[index][0]]

    while(coins[sortedCoins[index][0]] <= coin_max)
      if(index + 1 < coins.length)
        coin_iteration(coins,sortedCoins,index+1)
      else
        @runs += 1
        if(units(coins).to_f == 100.0)
          print_to_console(coins)
          @combos += 1
        end
      end
      coins[sortedCoins[index][0]] += 1
    end
    coins[sortedCoins[index][0]] = 0
  end

  def print_to_console(coins)

    output = coins.map{|element| "%10d" %element[1]}.join("")
    puts output
  end

  def max_coins(units_to_go)
    output = {}
    big_units_to_go = BigDecimal(units_to_go)
    @TypesOfChange.keys.each do |element|
      output[element] = (big_units_to_go / @TypesOfChange[element]).to_f.to_i
    end

    return output
  end

  def units(totalCoins)
    total = BigDecimal("0")
    @TypesOfChange.keys.each do |element|
      total += BigDecimal(@TypesOfChange[element] * totalCoins[element])
    end
    return total
  end

  def units_left(units)
    return BigDecimal(100) - units
  end

end

c1 = CustomCurrency.new(ARGV[0])
