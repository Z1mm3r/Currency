require 'pry'
class Solution

  def  self.all_possible_combos_first_method()
    # This relies on a brute force method to find all possible combinations.
    # not effecient but allows a baseline to be created in refactoring.
    # q = # of quarter d = dimes n = nickels and p = pennies

    combos = 0
    q = 0

    while q <= 4 do
      d = 0

      while d <= 10 do
        n = 0

        while n <= 20 do
          p = 0

          while p <= 100 do
            if (p + n * 5 + d * 10 + q * 25) == 100
              combos += 1
            end
              #We can add a small refinement... pennies will only give new combos when more than 5 are added or removed.
              p += 5
          end
          n += 1
        end
        d += 1
      end
      q += 1
    end

  puts combos

  end

  def self.all_possible_combos_second_method()
    #This method trims alot of the computational bloat from the brute force..
    #we no longer will look at combinations that go over 1$.
    #This leads to about an 80% reduction in computation time.

    combos = 0
    q = 0
    puts "%10{qu} %10{di} %10{ni} %10{pe}" %{qu: "Quarters", di: "Dimes", ni: "Nickles", pe: "Pennies"}
    while q <= 4 do

      d_max = max_coins(cents_left(cents(0,0,0,q)))[:d]

      d = 0
      while d <= d_max do

        n_max = max_coins(cents_left(cents(0,0,d,q)))[:n]
        n = 0

        while n <= n_max do
          p = 0
          p_max = max_coins(cents_left(cents(0,n,d,q)))[:p]
          while p <= p_max do
            if (p + n * 5 + d * 10 + q * 25) == 100
              puts "%10{qu} %10{di} %10{ni} %10{pe}" %{qu: q, di: d, ni: n, pe:p}
              combos += 1
            end
              p += 5
          end
          n += 1
        end
        d += 1
      end
      q += 1
    end

  puts "Count: #{combos}"


  end

  #helper functions to help organize logic.

  def self.cents(p,n,d,q)
    #returns total amount of cents.
    total =  p + n * 5 + d * 10 +  q * 25
    return total
  end

  def self.cents_left(centsTotal)
    #returns cents left available for combinations
    return 100 - centsTotal
  end

  def self.max_coins(cents_to_go)
    #returns max of each coin possible with cents left

    p = cents_to_go
    n = (cents_to_go / 5).round
    d = (cents_to_go / 10).round
    q = (cents_to_go / 25).round

    return {:p => p,:n => n,:d => d,:q => q}

  end

end




#testing..
#start = Time.now
#Solution.all_possible_combos_first_method()
#finish = Time.now
#puts finish - start
#start = Time.now
Solution.all_possible_combos_second_method()
#finish = Time.now
#puts finish - start
