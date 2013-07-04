function current_amount=win(bankroll,amount)
% FUNCTION that pays out players when they win
%inputs: bankroll - winning player bankroll
% amount: amount player bet
%outputs: current_amount- updated bankroll

        current_amount=bankroll+2*amount; %updates bankroll with new chips
    end