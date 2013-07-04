
function current_amount=blackjack(bankroll,amount)
%     function to pay out for blackjack
%         inputs: bankroll- player bankroll, amount- player bet
%         output: current amount- updated bankroll
        current_amount=bankroll+1.5*amount; %pays out 3:2 for blackjack
    end
