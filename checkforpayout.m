function[winorlose]=checkforpayout(hand,dealerhand,bust,dealerbust,fivecardcharlie)
%FUNCTION TO CHECK IF PLAYER IS A WINNER OR LOSER OR GETS A PUSH
%inputs: hand: chosen players final hand
%dealerhand: dealers final hand
% bust: whether or not player busted
% dealerbust: whether  or not dealer bust
% fivecardcharlie: checks if player got five card charlie
%outputs: winorlose: result for payout


if bust==1 % if player bust.. lose
    winorlose='lose';
elseif dealerbust==1 && bust==0 % if dealer bust.. player wins
    winorlose='wins';
elseif fivecardcharlie==1;% if player got a five card charlie,  wins
    winorlose='wins';
elseif sum(hand)>sum(dealerhand) % if player is closer to 21 than dealer, wins
    winorlose='wins';
elseif sum(hand)==sum(dealerhand) % if player has same value as dealer. push
    winorlose='push';
else %otherwise player loses
    winorlose='lose';
    
end
end

