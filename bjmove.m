function[chosenmove]=bjmove(hand,dealerfaceupval,ACE11,ACE1,ORGANIC)
% FUNCTION TO HELP BOTS MAKE MOVE INTELLIGENTLY 
%inputs: hand- player hand, dealerfaceupval- dealer showing card's value, 
%ACE11,ACE1,ORGANIC - move matrices
%outputs: chosen move- move based on cards and dealers cards

[f,r]=size(hand); % checks size of hand

[isace,hand,bust]=checkace(hand); %calls on checkace function 
if f==2 % if only 2 cards in hand
    for i=1:2
        if isace(i)==1 && hand(i)==11 % if theres an ace valued at 11
            [row,col]=find(ACE11==(sum(hand)));
            chosenmove=ACE11(row,dealerfaceupval); %find move in ACE 11 matrix 
        elseif isace(i)==1 && hand(i)==1 % if theres an ace valued at 1
            [row,col]=find(ACE1==sum(hand)); 
            chosenmove=ACE1(row,dealerfaceupval);% find move in ACE1 matrix
        else%if no aces
            [row,col]=find(ORGANIC==sum(hand));
            chosenmove=ORGANIC(row,dealerfaceupval); % find move in organic matrix
        end
    end
else % if theres more than 2 cards, use organic matrix
    [row,col]=find(ORGANIC==sum(hand));
    chosenmove=ORGANIC(row,dealerfaceupval);
end
end

%% if there is some ace in the hand and that ace is valued at 11
   %use the ACE 11 matrix, find sum of your hand for the row, and what
   %dealer is showing for the column
   %% if there is some ace in the hand but that ace is valued at 1
          %use the ACE 1 matrix
          %% if there are no aces
            %use ORGANIC matrix

    