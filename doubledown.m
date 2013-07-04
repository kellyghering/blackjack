function [current_amount,newbet]=doubledown(bankroll,amount)
%%function for doubling down bet
% input: bankroll: some players bankroll
% amount: bet
%output: current amount- updated player bankroll
%        newbet- updated player bet
current_amount=bankroll-amount; %updates player bankroll
newbet=amount*2; %updates bet
end