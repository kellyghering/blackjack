function current_amount=bet(amount,current_amount)
%%FUNCTION TO ALLOW USERS TO BET
% inputs: amount- amount player/user wants to bet.
%         current_amount: player_user bankroll
% output: current_amount: updates the bankroll
         current_amount=current_amount-amount; %subtracts bet from bankroll
end
  