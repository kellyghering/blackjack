function [move]=dealermove(dealerhand)
%%FUNCTION TO SERVE AS AI FOR DEALER TO MAKE MOVES
%inputs: dealerhand: dealer hand of card values
%outputs: move: number value for a move... 1 is hit, 2, stand.


%calls on check ace function to check for aces in the dealer hand
[isace,dealerhand,bust]=checkace(dealerhand);

    for i=1:length(dealerhand) %for loop to consider all values in dealer hand
    if sum(dealerhand)<=16 %if dealer has a 16 or less
        move=1; %hits
    elseif any(isace)==1 && sum(dealerhand)==17 %if its a soft 17
        move=1; %hit
    else
        move=2; %otherwise stand
    end
    end
    
end
