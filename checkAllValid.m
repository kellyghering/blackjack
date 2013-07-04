function areValid=checkAllValid(toCheck,database)
%function to check if elements in one array are in another, to declare if
%the array has valid characters or numbers.
%inputs:toCheck- the array that needs to be considered
%database-array of given characters or numbers
%output: areValid: equals 1 if valid and 0 if not. 

for i=1:length(toCheck) %for loop to consider all elements of toCheck array
    if isempty(find(toCheck(i)==database)); %if element is not in database, set that element of valid to 0
        valid(i)=0;
    else
        valid(i)=find(toCheck(i)==database); %if it is in database valid element is the index
    end
end
check=find(valid>0); %check is a new matrix containing indices of elements in valid that are greater than zero

if length(check)==length(toCheck) %checks that length of check is equal to length of toCheck, establishing toCheck as valid
    areValid=1; %areValid =1 because all characters or numbers are valid
else areValid=0;%areValid =0 because there is an invalid element in toCheck
end

end