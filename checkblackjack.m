 function [result]=checkblackjack(cardval1,cardval2)
 %function to check if a player/user/dealer has blackjack
 % inputs: cardval1: first dealt card value
 %cardval2: second dealt card value
 %outputs: result: 1 & 2 for blackjack, 0 for no blackjack
 %The reason for 2 blackjack values is so that you can tell whether the
 %dealer is showing an ace and then ask for insurance. If dealer is showing
 %a ten, you dont ask for insurance, therefore there must be a discrepancy.
 
 
 
            if (cardval1==11) && (cardval2==10) %if the hand has an 11 and 10 in values
                result=1; %there is blackjack, result is 1
            elseif (cardval2==11) && (cardval1==10) %if its reversed order, but still 11 and 10
                result=2; % %also blackjack, result is 2
            else
                result=0; %otherwise its not, therefore 0.
            end
 end