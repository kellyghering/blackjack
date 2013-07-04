function [ace,hand,bust]=checkace(hand)
%FUNCTION TO CHECK FOR AN ACE, POTENTIALLY CHANGE ITS VALUE, AND CHECK FOR
%BUST
% inputs: hand: a hand of card values
% Outputs: ace: row vector where 1 is ace and 0 is not an ace,
% corresponding to hand
%         hand: updated hand of card values
%         bust: 1 for bust, 0 for no bust.


for i=1:length(hand) % for loop considering all values in hand
    if hand(i)==11 || hand(i)==1 %if hand has a value of 11 or 1, signifying ace
        ace(i)=1; %set element in ace to 1
    else
        ace(i)=0; % if not set to 0
    end

    if sum(hand)>21 && hand(i)==11 %if the hand busted but theres an 11 in the hand
        hand(i)=1; %change the 11 to a 1
    end
end
%%checks for bust below:
if sum(hand)>21 %if the sum of the hand values is greater than 21
    bust=1; %player busts
else
    bust=0; %if not, no bust.
end

end

%% check for ace, check if bust, if busted, change ace value to 11 and check again
