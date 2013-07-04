function [bet,KOrun]=player4(cardvalues,numdecks,KOrun,bankroll)

%%FUNCTION TO CALCULATE COUNT AND BET FOR AI OF PLAYER 4
% inputs: cardvalues- matrix of card values dealt
 %numdecksleft: number of decks left to be dealt
 % numdecks: number of decks playing with
 % KOrun: current running count
%outputs: bet: bet based on advantage of count
% KOrun: updated running count

% THIS PLAYER IS USING Knockout SYSTEM OF COUNTING
%The system is unbalanced, so there is no true count

[k,l]=size(cardvalues);
count_values=[-1 1 1 1 1 1 1 0 0 -1]; %card values used for count
unit=10;

%calculates running count
for i=1:k
    if cardvalues(i,1)==11
        running_count=KOrun+count_values(1,1);
    elseif isempty(cardvalues)==1
        running_count=KOrun;
    else
        running_count=KOrun+count_values(cardvalues(i,1));
    end
    KOrun=running_count;%updates running count
end

%bets based on running count
for i=1:5
    if bankroll<10
        bet=0;
    elseif KOrun<=0
        bet=unit;
    elseif KOrun==i && numdecks<=6
        bet=unit*(i+1);
    elseif KOrun==i && numdecks>6
        bet=unit*(2i+2);
    else
        bet=unit*(2i+2);
    end
end



end