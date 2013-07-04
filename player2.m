function [bet,Zrun]=player2(cardvalues,numdecksleft,Zrun,bankroll)

%%FUNCTION TO CALCULATE COUNT AND BET FOR AI OF PLAYER 2
% inputs: cardvalues- matrix of card values dealt
 %numdecksleft: number of decks left to be dealt
 % numdecks: number of decks playing with
 % Zrun: current running count
%outputs: bet: bet based on advantage of count
% Zrun: updated running count

% THIS PLAYER IS USING THE ZEN METHOD OF CARD COUNTING
unit=10; % unit of 10

[k,l]=size(cardvalues);

count_values= [-1 1 1 2 2 2 1 0 0 -2]; % count values matrix

%calculates running count
for i=1:k
    if cardvalues(i,1)==11
        running_count=Zrun+count_values(1,1);
    elseif isempty(cardvalues)==1
        running_count=Zrun;
    else
        running_count=Zrun+count_values(cardvalues(i,1));
    end
    Zrun=running_count; %updates curret count
end
%calculates true count
if numdecksleft==0
    true_count=round(Zrun/(numdecksleft+.5));
else
    true_count=round(Zrun/numdecksleft);
end

%bets based on true count
for i=2:10
    if bankroll<10
        bet=0;
    elseif true_count<=1
        bet=unit;
    elseif true_count==i
        bet=unit*i
    end
    
end
end