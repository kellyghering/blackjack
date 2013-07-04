function [bet,HOrun]=player3(cardvalues,numdecksleft,numdecks,HOrun,bankroll)
%%FUNCTION TO CALCULATE COUNT AND BET FOR AI OF PLAYER 3
% inputs: cardvalues- matrix of card values dealt
 %numdecksleft: number of decks left to be dealt
 % numdecks: number of decks playing with
 % HOrun: current running count
%outputs: bet: bet based on advantage of count
% HOrun: updated running count

%this player is using the Hi-Opt I Method of counting


unit=10; %unit is 10
[k,l]=size(cardvalues);
count_values=[0 0 1 1 1 1 0 0 0 -1]; %values used for counting

%calculate running count
for i=1:k
    if cardvalues(i,1)==11
        running_count=HOrun+count_values(1,1);
    elseif isempty(cardvalues)==1
        running_count=HOrun;
    else
        running_count=HOrun+count_values(cardvalues(i,1));
    end
    HOrun=running_count; %updates current count
end
%calculate true count.. true count= running count/number of decks left
if numdecksleft==0
    true_count=round(HOrun/(numdecksleft+.5));
else
    true_count=round(HOrun/numdecksleft);
   
end
%bets based on true count
for i=1:5
    if bankroll<10
        bet=0;
    elseif true_count<=0
        bet=unit;
    elseif true_count==i && numdecks<=6
        bet=unit*(i+1);
    elseif true_count==i && numdecks>6
        bet=unit*(2i+2);
    else
        bet=unit*(2i+2);
    end
end


end