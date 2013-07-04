
function [card,value,decks,checkreset,sizedeck]=deal(numdecks,decks,numplayers)
%%FUNCTION TO DEAL A CARD TO PLAYERS
% Inputs: numdecks: number of decks user inputs to play with
% decks: the deck being played with currently
% numplayers: number of players in game other than user and dealer
% Outputs: card: dealt card
% value: dealt cards value
% decks: the new updated deck
% checkreset: value to notify if deck has been reset
% sizedeck= size of deck currently


[h,g]=size(decks);%checks size of input decks
if h<(numplayers+2)*2 %if its not big enough, makes a new deck
deck=['AH';'2H';'3H';'4H';'5H';'6H';'7H';'8H';'9H';'TH';'JH';'QH';'KH';...
    'AS';'2S';'3S';'4S';'5S';'6S';'7S';'8S';'9S';'TS';'JS';'QS';'KS';...
    'AC';'2C';'3C';'4C';'5C';'6C';'7C';'8C';'9C';'TC';'JC';'QC';'KC';...
    'AD';'2D';'3D';'4D';'5D';'6D';'7D';'8D';'9D';'TD';'JD';'QD';'KD']; %full deck of cards with suits
decks=repmat(deck,numdecks,1);%makes set of decks
checkreset=1; %means that deck was reset
else
    decks=decks; %if not use input deck
    checkreset=0; %not reset
end
[u,v]=size(decks); %checks size of deck again
sizedeck=u;
cardvals=[11,2,3,4,5,6,7,8,9,10,10,10,10]; %vector of card values A-K
cardsym=['A';'2';'3';'4';'5';'6';'7';'8';'9';'T';'J';'Q';'K'];%vector of card symbols
random_card=ceil(u*rand(1));%indexes a random number of card
card=decks(random_card,:); % pulls that element from the deck
decks(random_card,:)=[]; % eliminates that element from the deck

if card(1,1)=='T'|| card(1,1)=='J'||card(1,1)=='Q'||card(1,1)=='K' %% gives ten, jack, queen and king a value of 10
    value=10; 
elseif card(1,1)=='A'%gives ace a value of 11
        value=11;
else value=cardvals(1,str2num(card(1,1))); % otherwise gives the numbers their own number values
    
end
end
