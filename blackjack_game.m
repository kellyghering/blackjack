%Blackjack!
%Author: Kelly Hering
%Date: 5/13/11

%This m-file simulates a playable blackjack game.
% There are 4 bots with AI of all different types.
% Player 1 is card counting using the Hi-Lo Method
% Player 2 is card counting using the Zen Method.
% Player 3 is card counting using the Hi Opt I Method.
% Player 4 is card counting using the Knock Out Method.
%Bots bet corresponding to advantage.

%The dealer plays with an AI typical in casinos:
% Always hits on 16 or less, as well as soft 17. Otherwise stands.

%User can input name, number of decks, their bets, and moves.


%Rules are as follows:
%objective: get as close to 21 without going over 21

%Betting: minimum bet is 10... if bankroll falls lower than 10, Game Over.

%Possible Moves
% Hit - take another card
% Stand - take no more cards
% Double - double bet and take one more card

%Payout:
%Win- you win the amount equal to your bet. This happens if you do not
%bust, meaning go over 21, and the dealer's cards have a value lower than
%yours, or dealer busts.
%Push- if you have the same value as the dealer, less than 21, you keep
%your bet.
%Lose- you lose if you bust, or if the dealer has a higher value than yours
%less than 21.
%Blackjack- Blackjack pays 3:2, this means you have an Ace and a card of 10
%value.



%FUNCTIONS
% deal.m
% checkforpayout.m
% bjmove.m
% imageread.m
% checkace.m
% win.m
% push.m
% blackjack.m
% doubledown.m
% dealermove.m
% checkAllValid.m
% checkblackjack.m
% player1.m
% player2.m
% player3.m
% player4.m



function blackjack_game
clear; %clears previous variables

player_bankroll=1000; %sets initial user bankroll
while (player_bankroll~=0) % while loop to check if player is bankrupt
    %% SETUP
    disp('Ready to play Blackjack?')
    name=input('What is your name?\n','s');
    %numplayers=input('How many additional players would you like at the table? (Max: 4)\n');
    numplayers=4;%sets number of players=4
    validdecks=0;
    validdecknum=[0 1 2 3 4 5 6 7 8]; %database of valid inputs for deck
    while (validdecks~=1)
        numdecks=input('How many decks would you like to play with? (Max: 8)\n');
        validdecks=checkAllValid(numdecks,validdecknum);
        if validdecks==0
            disp('Invalid deck amount! Try again!')
        end
    end
    fprintf('There are %g players. You are the last seat before the dealer.\n', (numplayers+1))
    p1bankroll=1000;
    p2bankroll=1000;
    p3bankroll=1000;
    p4bankroll=1000;
    
    %[m,n]=size(decks) %%% need to get this somehow to get numdecksleft
    %% BETS
    hand=1;
    numberofhandsplayed=0;%count for number of hands played
    while (hand~=0) % while loop for a single hand
        close all;
        
        %sets Five Card Charlie variable
        p1fcc=0;
        p2fcc=0;
        p3fcc=0;
        p4fcc=0;
        ufcc=0;
        insurance=0;
        
        %checks the number of decks left
        if numberofhandsplayed==0
            numdecksleft=numdecks;
        else numdecksleft=round(sizedecks/numdecks);
        end
        
        %sets initial variables if the game has just begun
        if numberofhandsplayed==0;
            values=[];
            decks=0;
            checkreset=1;
        end
        
        %sets initial running card counts for players
        if checkreset==1
            HLrun=0;
            Zrun=0;
            HOrun=0;
            KOrun=0;
        end
        
        
        % runs each player's function to determine their bet
        [p1bet,HLrun]=player1(values,numdecksleft,numdecks,HLrun,p1bankroll);
        [p2bet,Zrun]=player2(values,numdecksleft,Zrun,p2bankroll);
        [p3bet,HOrun]=player3(values,numdecksleft,numdecks,HOrun,p3bankroll);
        [p4bet,KOrun]=player4(values,numdecks,KOrun,p4bankroll);
        
        %uses bet function to update bankrolls
        p1bankroll=bet(p1bet,p1bankroll);
        p2bankroll=bet(p2bet,p2bankroll);
        p3bankroll=bet(p3bet,p3bankroll);
        p4bankroll=bet(p4bet,p4bankroll);
        
        %prints each bet and bankroll
        fprintf('Player 1 bets %g. Current bankroll: %g in chips.\n',p1bet,p1bankroll)
        pause(.5)
        fprintf('Player 2 bets %g. Current bankroll: %g in chips.\n',p2bet,p2bankroll)
        pause(.5)
        fprintf('Player 3 bets %g. Current bankroll: %g in chips.\n',p3bet,p3bankroll)
        pause(.5)
        fprintf('Player 4 bets %g. Current bankroll: %g in chips.\n',p4bet,p4bankroll)
        pause(.5)
        
        
        
        minbet=10; % mininum bet
        maxbet=player_bankroll; % can bet as much as bankroll
        valid1=1;
        while (valid1~=0)
            fprintf('You have %g in chips.\n', player_bankroll)
            userbet=input('How much would you like to bet? (Min: 10)\n');%user inputs bet
            if maxbet<userbet || userbet<minbet
                disp('Invalid bet amount! Try again!')
            else
                valid1=0;
            end
        end
        
        [player_bankroll]=bet(userbet,player_bankroll);
        
        
        %% shows users's bet
        
        fprintf('%s bets %g. Current bankroll: %g in chips.\n',name,userbet,player_bankroll)
        
        
        
        %% DEAL
        
        
        figure;
        set(gcf, 'Position', get(0,'Screensize'));%makes figure the size of screen
        
        % deals cards
        for i=1:12 %for loop in order to deal out the right amount of cards
            [card,value,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);%function to deal
            cards(i,:)=card;%creates matrix of all cards
            values(i,1)=value;%creates matrix of all values
            
        end
        
        %shows cards in a figure in the right subplot format using image toolbox
        i=1;
        j=1;
        while (j<=11)
   
                [imagedata]=imageread(cards(j,:));
                subplot(6,5,i), imshow(imagedata);
                
                if i==1
                    ylabel('Player 1');
                elseif i==6
                    ylabel('Player 2');
                elseif i==11
                    ylabel('Player 3');
                elseif i==16
                    ylabel('Player 4');
                elseif i==21
                    ylabel('You');
                elseif i==26
                    ylabel('Dealer');
                end
  
            pause(.25)
            if mod(j,2)==0
                i=i+4;
                
            else
                i=i+1;
                
            end
            j=j+1;
            
        end
        %shows facedown card for dealer card
        facedown=imread('facedown.png');
        subplot(6,5,27),imshow(facedown); %imshow to show card
      
        %creates hands for players, users and dealers of card values
        p1hand=[values(1) values(2)];
        p2hand=[values(3) values(4)];
        p3hand=[values(5) values(6)];
        p4hand=[values(7) values(8)];
        userhand=[values(9) values(10)];
        dealerhand=[values(11) values(12)];
        
        %calls on check ace function for all hands
        [ace,p1hand,p1bust]=checkace(p1hand);
        [ace,p2hand,p2bust]=checkace(p2hand);
        [ace,p3hand,p3bust]=checkace(p3hand);
        [ace,p4hand,p4bust]=checkace(p4hand);
        [ace,userhand,userbust]=checkace(userhand);
        
        %Prints what was dealt
        fprintf('Player 1 was dealt: %s %s  Value:%g\n',cards(1,:),cards(2,:),sum(p1hand))
        pause(1)
        fprintf('Player 2 was dealt: %s %s  Value:%g\n',cards(3,:),cards(4,:),sum(p2hand))
        pause(1)
        fprintf('Player 3 was dealt: %s %s  Value:%g\n',cards(5,:),cards(6,:),sum(p3hand))
        pause(1)
        fprintf('Player 4 was dealt: %s %s  Value:%g\n',cards(7,:),cards(8,:),sum(p4hand))
        pause(1)
        fprintf('You were dealt: %s %s  Value:%g\n', cards(9,:),cards(10,:),sum(userhand))
        pause(1)
        fprintf('The dealer is showing a %s  Value:%g\n', cards(11,:),values(11))
        
        %if dealer has ace, prompts for insurance and checks for blackjack
        if cards(11,1)=='A'
            validinsure=['Y';'y';'N';'n']; % valid responses
            validinsurance=0;
            while validinsurance~=1 % while loop to check if valid response
                insurance=input('The Dealer is showing an Ace. Would you like insurance? Y/N\n','s');
                validinsurance=checkAllValid(insurance,validinsure);
                if validinsurance==0
                    disp('Invalid response. Try again!');
                end
            end
            
            [dealerresult]=checkblackjack(values(11,1),values(12,1));
            [userresult]=checkblackjack(values(9,1),values(10,1));
            if insurance=='Y' || insurance=='y' % if user wants insurance
                validwager=0;
                while validwager~=1
                insurancewager=input('How much would you like to wager? You may wager up to half of your original bet.\n');
                if 0<=insurancewager && insurancewager<(userbet/2)
                player_bankroll=bet(insurancewager,player_bankroll);
                validwager=1;
                else
                    disp('Invalid wager amount. Try again.')
                end
                end
                
                if dealerresult==1 && userresult==1 %checks if both user and dealer got blackjack
                    [player_bankroll]=push(player_bankroll,userbet);
                    [player_bankroll]=win(player_bankroll,insurancewager);
                    fprintf('You got blackjack! But so did the dealer...insurance pays 2:1')
                elseif dealerresult==1 && userresult==0 %if dealer got blackjack but user did not
                    [player_bankroll]=win(player_bankroll,insurancewager);
                    disp('The dealer has blackjack! Insurance pays 2:1, but you lose your bet.')
                    [imagedata]=imageread(cards(12,:));
                    subplot(6,5,27,'replace'), imshow(imagedata);
                else %if dealer doesnt have blackjack.. continue
                    disp('The dealer does not have blackjack. Continue gameplay.')
                end
            end
            if insurance=='N'||insurance=='n'
                if dealerresult==0
                 disp('Dealer does not have blackjack. Continue gameplay');
                end
            end
                    
            
        end
        
        %%CALLS ON FUNCTION TO CHECK IF EACH PLAYER HAS BLACKJACK
        [dealerresult]=checkblackjack(values(11,1),values(12,1));
        
        [p1result]=checkblackjack(values(1,1),values(2,1));
        if (p1result==1 || p1result==2) && dealerresult==0
            disp('Player 1 got blackjack! Blackjack pays 3:2.');
            [p1bankroll]=blackjack(p1bankroll,p1bet);
        elseif p1result==1 && (dealerresult==1 || dealerresult==2)
            p1bankroll=push(p1bankroll,p1bet);
        end
        [p2result]=checkblackjack(values(3,1),values(4,1));
        if (p2result==1 || p2result==2) && dealerresult==0
            disp('Player 2 got blackjack! Blackjack pays 3:2.');
            [p2bankroll]=blackjack(p2bankroll,p2bet);
        elseif p2result==1 && (dealerresult==1 || dealerresult==2)
            p2bankroll=push(p2bankroll,p2bet);
        end
        [p3result]=checkblackjack(values(5,1),values(6,1));
        if (p3result==1 || p3result==2) && dealerresult==0
            disp('Player 3 got blackjack! Blackjack pays 3:2.');
            [p3bankroll]=blackjack(p3bankroll,p3bet);
        elseif p3result==1 && (dealerresult==1 || dealerresult==2)
            p3bankroll=push(p3bankroll,p3bet);
        end
        [p4result]=checkblackjack(values(7,1),values(8,1));
        if (p4result==1 || p4result==2) && dealerresult==0
            disp('Player 4 got blackjack! Blackjack pays 3:2.');
            [p4bankroll]=blackjack(p4bankroll,p4bet);
        elseif p4result==1 && (dealerresult==1 || dealerresult==2)
            p4bankroll=push(p4bankroll,p4bet);
        end
        [userresult]=checkblackjack(values(9,1),values(10,1));
        if (userresult==1|| userresult==2) && dealerresult==0
            fprintf('%s got blackjack! Blackjack pays 3:2.\n',name);
            [player_bankroll]=blackjack(player_bankroll,userbet);
        elseif userresult==1 && (dealerresult==1 || dealerresult==2)
            player_bankroll=push(player_bankroll,userbet);
        end
        
        
        
        
        %% MOVES
        % 1=hit
        % 2=stand
        % 0=double
        
        %checks for blackjack for dealer
        [dealerresult]=checkblackjack(values(11,1),values(12,1));
       
        %Dealer: 2 3 4 5 6 7 8 9 10 11
        
        %if theres an ace at value 11
        ACE11=[12 1 1 1 1 1 1 1 1 1 1;
            13 1 1 1 1 0 1 1 1 1 1;
            14 1 1 1 0 0 1 1 1 1 1;
            15 1 1 1 0 0 1 1 1 1 1;
            16 1 1 0 0 0 1 1 1 1 1;
            17 1 0 0 0 0 1 1 1 1 1;
            18 2 0 0 0 0 2 2 1 1 1;
            19 2 2 2 2 2 2 2 2 2 2;
            20 2 2 2 2 2 2 2 2 2 2];
        
        %if there is an ace and its value is one..
        ACE1=[3 1 1 1 1 0 1 1 1 1 1;
            4 1 1 1 0 0 1 1 1 1 1;
            5 1 1 1 0 0 1 1 1 1 1;
            6 1 1 0 0 0 1 1 1 1 1;
            7 1 0 0 0 0 1 1 1 1 1;
            8 2 0 0 0 0 2 2 1 1 1;
            9 2 2 2 2 2 2 2 2 2 2;
            10 2 2 2 2 2 2 2 2 2 2];
        
        % if there are no aces in the hand...
        ORGANIC=[4 1 1 1 1 1 1 1 1 1 1;
            5 1 1 1 1 1 1 1 1 1 1;
            6 1 1 1 1 1 1 1 1 1 1;
            7 1 1 1 1 1 1 1 1 1 1;
            8 1 1 1 1 1 1 1 1 1 1;
            9 1 0 0 0 0 1 1 1 1 1;
            10 0 0 0 0 0 0 0 0 1 1;
            11 0 0 0 0 0 0 0 0 1 1;
            12 1 1 2 2 2 1 1 1 1 1;
            13 2 2 2 2 2 1 1 1 1 1;
            14 2 2 2 2 2 1 1 1 1 1;
            15 2 2 2 2 2 1 1 1 1 1;
            16 2 2 2 2 2 1 1 1 1 1;
            17 2 2 2 2 2 2 2 2 2 2;
            18 2 2 2 2 2 2 2 2 2 2;
            19 2 2 2 2 2 2 2 2 2 2;
            20 2 2 2 2 2 2 2 2 2 2;
            21 2 2 2 2 2 2 2 2 2 2];
        
        
        %%PLAYER 1 TURN
        %checks to see if player 1 or dealer already had blackjack to skip
        %turn if that happened
        if (p1result==1|| p1result==2) || dealerresult==1
            p1bust=0;
            player1turn=0;
        else
            player1turn=1;
            dealerfaceval=values(11);
            
        end
        
        while player1turn~=0%while loop for player 1s turn
            [p1move]=bjmove(p1hand,dealerfaceval,ACE11,ACE1,ORGANIC);
            if p1move==1 % if hit
                [hit1,val,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                fprintf('Player 1 hits: %s\n',hit1)
                [imagedata]=imageread(hit1);
                subplot(6,5,2+player1turn), imshow(imagedata);
                p1hand=[p1hand val];
                [ace,p1hand,p1bust]=checkace(p1hand);
                if p1bust==1 % if bust
                    disp('Player 1 busts.')
                    player1turn=0;
                else % cant double after first hit
                    ACE11(ACE11==0)=1;
                    ACE1(ACE1==0)=1;
                    ORGANIC(ORGANIC==0)=1;
                    player1turn=player1turn+1;
                    if player1turn==5 % checks 5 card charlie
                        disp('Player 1 got a Five Card Charlie!')
                        p1fcc=1;
                        player1turn=0;
                    end
                end
            elseif p1move==2 %if stand
                fprintf('Player 1 stands with a %g.\n',sum(p1hand))
                [ace,p1hand,p1bust]=checkace(p1hand);
                player1turn=0;%end turn
            elseif p1move==0%if double down
                [hit1,val,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                fprintf('Player 1 doubled down: %s\n',hit1)
                [p1bankroll,p1bet]=doubledown(p1bankroll,p1bet);
                p1hand=[p1hand val];
                [ace,p1hand,p1bust]=checkace(p1hand);
                [imagedata]=imageread(hit1);
                subplot(6,5,3), imshow(imagedata);
                if p1bust==1
                    disp('Player 1 busts.')
                end
                player1turn=0;%end turn after 1 hit
            end
            pause(1)
            
        end
        
        %%PLAYER TWO TURN
        
        %checks if needs to skip turn because of blackjack
        if (p2result==1 || p2result==2) || dealerresult==1
            p2bust=0;
            player2turn=0;
        else
            player2turn=1;
            dealerfaceval=values(11);
            
        end
        
        while player2turn~=0%while loop for player 2 turn
            [p2move]=bjmove(p2hand,dealerfaceval,ACE11,ACE1,ORGANIC);
            if p2move==1 % if hit
                [hit2,val,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                fprintf('Player 2 hits: %s\n',hit2)
                [imagedata]=imageread(hit2);
                subplot(6,5,7+player2turn), imshow(imagedata);
                p2hand=[p2hand val];
                [ace,p2hand,p2bust]=checkace(p2hand);
                if p2bust==1 % checks bust
                    disp('Player 2 busts.')
                    player2turn=0;
                else % cant double after first turn
                    ACE11(ACE11==0)=1;
                    ACE1(ACE1==0)=1;
                    ORGANIC(ORGANIC==0)=1;
                    player2turn=player2turn+1;
                    if player2turn==5 % checks 5 card charlie
                        disp('Player 2 got a Five Card Charlie!')
                        p2fcc=1;
                        player2turn=0;
                    end
                end
            elseif p2move==2 % if stand
                fprintf('Player 2 stands with a %g.\n',sum(p2hand))
                [ace,p2hand,p2bust]=checkace(p2hand);
                player2turn=0;
                
            elseif p2move==0 % if double down
                [hit2,val,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                fprintf('Player 2 doubled down: %s\n',hit2)
                [p2bankroll,p2bet]=doubledown(p2bankroll,p2bet);
                [imagedata]=imageread(hit2);
                subplot(6,5,8), imshow(imagedata);
                p2hand=[p2hand val];
                [ace,p2hand,p2bust]=checkace(p2hand);
                if p2bust==1
                    disp('Player 2 busts.')
                end
                player2turn=0;
            end
            
        end
        pause(1)
        %%PLAYER 3 TURN
        
       %skips turn if they or dealer got blackjack
        if (p3result==1 || p3result==2) || dealerresult==1
            p3bust=0;
            player3turn=0;
        else
            player3turn=1;
            dealerfaceval=values(11);
            
        end
        
        while player3turn~=0 %loop for player 3s turn, calls on bjmove function
            [p3move]=bjmove(p3hand,dealerfaceval,ACE11,ACE1,ORGANIC);
            if p3move==1 % if hit
                [hit3,val,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                fprintf('Player 3 hits: %s\n',hit3)
                [imagedata]=imageread(hit3);
                subplot(6,5,12+player3turn), imshow(imagedata);
                p3hand=[p3hand val];
                [ace,p3hand,p3bust]=checkace(p3hand);
                if p3bust==1
                    disp('Player 3 busts.')
                    player3turn=0;
                else %after they hit once, no longer option to double down
                    ACE11(ACE11==0)=1;
                    ACE1(ACE1==0)=1;
                    ORGANIC(ORGANIC==0)=1;
                    player3turn=player3turn+1;
                    if player3turn==5%checks for 5 card charlie
                        disp('Player 3 got a Five Card Charlie!')
                        p3fcc=1;
                        player3turn=0;
                        
                    end
                end
            elseif p3move==2% if stand
                fprintf('Player 3 stands with a %g.\n',sum(p3hand))
                [ace,p3hand,p3bust]=checkace(p3hand);
                player3turn=0;
            elseif p3move==0 % if double
                [hit3,val,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                fprintf('Player 3 doubled down: %s\n',hit3)
                [p3bankroll,p3bet]=doubledown(p3bankroll,p3bet);
                [imagedata]=imageread(hit3);
                subplot(6,5,13), imshow(imagedata);
                p3hand=[p3hand val];
                [ace,p3hand,p3bust]=checkace(p3hand);
                if p3bust==1
                    disp('Player 3 busts.')
                    player3turn=0;
                end
                player3turn=0;
            end
            
        end
        
        pause(1)
        
        %%PLAYER 4 TURN
        
        %skips turn if player or dealer got blackjack
        if (p4result==1 || p4result==2) || dealerresult==1
            p4bust=0;
            player4turn=0;
        else
            player4turn=1;
            dealerfaceval=values(11);
            
        end
        
        while player4turn~=0 % while loop for player 4 turn
            [p4move]=bjmove(p4hand,dealerfaceval,ACE11,ACE1,ORGANIC);
            if p4move==1
                [hit4,val,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                fprintf('Player 4 hits: %s\n',hit4)
                [imagedata]=imageread(hit4);
                subplot(6,5,17+player4turn), imshow(imagedata);
                p4hand=[p4hand val];
                [ace,p4hand,p4bust]=checkace(p4hand);
                if p4bust==1
                    disp('Player 4 busts.')
                    player4turn=0;
                else % eliminates double option
                    ACE11(ACE11==0)=1;
                    ACE1(ACE1==0)=1;
                    ORGANIC(ORGANIC==0)=1;
                    player4turn=player4turn+1;
                    if player4turn==5
                        disp('Player 4 got a Five Card Charlie!')
                        p4fcc=1;
                        player4turn=0;
                    end
                end
            elseif p4move==2 %if stand 
                fprintf('Player 4 stands with a %g.\n',sum(p4hand))
                [ace,p4hand,p4bust]=checkace(p4hand);
                player4turn=0;
            elseif p4move==0 %if double down
                [ace,p4hand,p4bust]=checkace(p4hand);
                [hit4,val,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                fprintf('Player 4 doubled down: %s\n',hit4)
                [p4bankroll,p4bet]=doubledown(p4bankroll,p4bet);
                [imagedata]=imageread(hit4);
                subplot(6,5,18), imshow(imagedata);
                p4hand=[p4hand val];
                [ace,p4hand,p4bust]=checkace(p4hand);
                if p4bust==1
                    disp('Player 4 busts.')
                    player4turn=0;
                end
                player4turn=0;
            end
            
        end
        
        
        pause(2)
        %%USER move
        
        %checks if user or dealer has blackjack
        if (userresult==1 || userresult==2) || dealerresult==1
            userbust=0;
            turn=0;
        else
            turn=1;
            validmove=0;
            validmoves=['H';'h';'S';'s';'D';'d']; %valid responses
            while validmove~=1 %loop for check valid
            move=input('Would you like to hit, stand, or double down? H/S/D\n','s');
            validmove=checkAllValid(move,validmoves);
            if validmove==0
                disp('Invalid Response! Try again.')
            end
            end
        end
        
        while turn~=0 % while loop for user turn
            
            if move=='H'|| move=='h' %if hit
                [hitcard,value,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                userhand=[userhand value];
                [a,userhand,userbust]=checkace(userhand);
                fprintf('You hit: %s. Value: %g\n', hitcard,sum(userhand))
                [imagedata]=imageread(hitcard);
                subplot(6,5,22+turn), imshow(imagedata);
                if userbust==1;
                    disp('You bust. Sorry!')
                    turn=0;
                else
                    turn=turn+1;
                    if turn==5 % checks for 5 card charlie
                        fprintf('%s got a Five Card Charlie!',name)
                        ufcc=1;
                        turn=0;
                    else
                        validmoves2=['H';'S';'h';'s'];
                        validmove2=0;
                        while validmove2~=1
                            move=input('Would you like to hit again or stand? H/S\n','s');
                            validmove2=checkAllValid(move,validmoves2);
                            if validmove2==0
                                disp('Invalid Response! Try again.')
                            end
                        end
                    end

                end
                
            elseif move=='S'|| move=='s' % if stand
                fprintf('You stand with a %g.\n',sum(userhand));
                [a,userhand,userbust]=checkace(userhand);
                turn=0;
            elseif move=='D'|| move=='d' %if double down
                [hitcard,value,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                fprintf('You doubled down: %s\n',hitcard)
                [player_bankroll,userbet]=doubledown(player_bankroll,userbet);
                [imagedata]=imageread(hitcard);
                subplot(6,5,23), imshow(imagedata);
                userhand=[userhand value];
                [a,userhand,userbust]=checkace(userhand);
                if userbust==1 %checks bust
                    disp('You bust. Sorry!')
                end
                turn=0;
            end
            
            
        end
        pause(2)
        
        %checks if dealer has blackjack
        [dealerresult]=checkblackjack(values(11,1),values(12,1));
        if dealerresult==1
            dealerturn=0;
        else
            dealerturn=1;
            fprintf('Dealer hole card is a %s\n', cards(12,:))
            [imagedata]=imageread(cards(12,:)); % show hole card
            subplot(6,5,27,'replace'), imshow(imagedata);
        end
        %dealer's turn
        
        
        while dealerturn~=0
            if dealerresult==2 % if dealer has blackjacj
                disp('Oh no! The dealer has blackjack!')
                dealerturn=0;
            end
            %calls on dealer move function
            [dealersmove]=dealermove(dealerhand);
            if dealersmove==1 % if dealer hits
                [dealerhit,value,decks,checkreset,sizedecks]=deal(numdecks,decks,numplayers);
                dealerhand=[dealerhand value];
                [imagedata]=imageread(dealerhit);
                subplot(6,5,27+dealerturn), imshow(imagedata);
                fprintf('Dealer hits: %s\n', dealerhit)
                [ace,dealerhand,bust]=checkace(dealerhand);
                if bust==0
                    dealerbust=0;
                    dealerturn=dealerturn+1;
                elseif bust==1
                    disp('The dealer busts!')
                    dealerbust=1;
                    dealerturn=0;
                end
            else  %otherwise, stand
                dealerturn=0; 
                fprintf('Dealer stands with a %g.\n',sum(dealerhand))
                dealerbust=0;
            end
            
        end
        
        %%Payout
        
        %calls on checkforpayout function & correspnding functions
        
        if dealerresult==1 || dealerresult==2;
            disp('Dealer has blackjack. Everyone loses their bet, except those with blackjack, push.')
        else
            [p1result]=checkforpayout(p1hand,dealerhand,p1bust,dealerbust,p1fcc);
            if p1result=='wins'
                p1bankroll=win(p1bankroll,p1bet);
            elseif p1result=='push'
                p1bankroll=push(p1bankroll,p1bet);
            end
            
            [p2result]=checkforpayout(p2hand,dealerhand,p2bust,dealerbust,p2fcc);
            if p2result=='wins'
                p2bankroll=win(p2bankroll,p2bet);
            elseif p1result=='push'
                p2bankroll=push(p2bankroll,p2bet);
            end
            
            [p3result]=checkforpayout(p3hand,dealerhand,p3bust,dealerbust,p3fcc);
            if p3result=='wins'
                p3bankroll=win(p3bankroll,p3bet);
            elseif p3result=='push'
                p3bankroll=push(p3bankroll,p3bet);
            end
            [p4result]=checkforpayout(p4hand,dealerhand,p4bust,dealerbust,p4fcc);
            if p4result=='wins'
                p4bankroll=win(p4bankroll,p4bet);
            elseif p1result=='push'
                p4bankroll=push(p4bankroll,p4bet);
            end
            [userresult]=checkforpayout(userhand,dealerhand,userbust,dealerbust,ufcc);
            if userresult=='wins'
                player_bankroll=win(player_bankroll,userbet);
            elseif userresult=='push'
                player_bankroll=push(player_bankroll,userbet);
            end
        end
        
       
        
        %prints players new bankrolls
        bankrolls=[p1bankroll,p2bankroll,p3bankroll,p4bankroll,player_bankroll];
        for i=1:4
            fprintf('Player %g now has %g in chips.\n',i,bankrolls(i))
            pause(.5)
        end
        fprintf('%s now has %g in chips.\n',name,player_bankroll)
        
        %updates counter for number of hands played
        numberofhandsplayed=numberofhandsplayed+1;
        
        money1(1)=1000;
        money1(numberofhandsplayed+1)=p1bankroll;
        money2(1)=1000;
        money2(numberofhandsplayed+1)=p2bankroll;
        money3(1)=1000;
        money3(numberofhandsplayed+1)=p3bankroll;
        money4(1)=1000;
        money4(numberofhandsplayed+1)=p4bankroll;
        money5(1)=1000;
        money5(numberofhandsplayed+1)=player_bankroll;
        
        if player_bankroll<10
            break;
        end
    end
    if player_bankroll<10 %if player bankroll is less than 10, game over
        player_bankroll=0;
    end
end



pause(2)
close all;

%%game over, now checks if they want to see stats
validstat=0;
validstatinput=['Y';'y';'N';'n'];
while validstat~=1
stats=input('Sorry! Game over. Would you like to see the stats? Y/N \n','s');
validstat=checkAllValid(stats,validstatinput);
if validstat==0
    disp('Invalid Response! Try again.')
end
end

if stats=='Y'|| stats=='y'
    %plots stats
    numhands=0:numberofhandsplayed;
    figure;
    title('Blackjack Statistics');
    xlabel('Number of Hands')
    ylabel('Amount of Chips')
    plot(numhands,money1);
    hold all;
    plot(numhands,money2)
    plot(numhands,money3)
    plot(numhands,money4)
    plot(numhands,money5)
    legend('Player 1','Player 2','Player 3','Player 4', 'You','Location','Southwest')
end



end
