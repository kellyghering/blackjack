function [bet,HLrun]=player1(cardvalues,numdecksleft,numdecks,HLrun,bankroll)
%%FUNCTION TO CALCULATE COUNT AND BET FOR AI OF PLAYER 1
% inputs: cardvalues- matrix of card values dealt
 %numdecksleft: number of decks left to be dealt
 % numdecks: number of decks playing with
 % HLrun: current running count
%outputs: bet: bet based on advantage of count
% HLrun: updated running count

%This Player is using the HI LO method of card counting

unit=10; % unit size 10
[k,l]=size(cardvalues); % calculate size of card values matrix
count_values= [-1 1 1 1 1 1 0 0 0 -1]; % values for count corresponding with A-K

%calculates running count
for i=1:k
    if cardvalues(i,1)==11 
        running_count=HLrun+count_values(1,1);
    elseif isempty(cardvalues)==1
        running_count=HLrun;
    else
        running_count=HLrun+count_values(cardvalues(i,1));
    end
    HLrun=running_count; %updates current count
end

%calculates true count
if numdecksleft==0 
    true_count=round(HLrun/(numdecksleft+.5));
else
    true_count=round(HLrun/numdecksleft);
end

%bets based on true count
for i=1:5
    if bankroll<10
        bet=0;
    elseif true_count<=0
        bet=unit;
    elseif true_count==i && numdecks<=6
        bet=unit*(i+1)
    elseif true_count==i && numdecks>6
        bet=unit*(2i+2)
    end
    
end

end