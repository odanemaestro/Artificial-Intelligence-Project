:- dynamic riskethnicity/1.
:- dynamic riskgender/1.
:- dynamic riskindex/1.

riskethnicity(african).
riskgender(male).
riskindex(25).

% primary function
get_choice:- nl, write('1. Populate the Database'), nl, write('2. Take Survey'),nl, write('3. Exit'),nl, nl, write('Enter your choice here: '), nl, read(Choice),
(Choice==1 ->get_riskethnicity,get_riskgender,get_riskind; Choice==2 ->survey; Choice ==3 ->nl, write('Thank you for participating in our survey'); nl, write('Invalid choice made'), get_choice).


% code to populate the database

get_riskethnicity:- nl, write('Enter your ethnicity: '),nl,
read(Ethnic), (riskethnicity(Ethnic)-> nl,write('Ethnicity already recorded');
assert(riskethnicity(Ethnic)),nl,write('Ethnicity successfully recorded')).

get_riskgender:- nl, write('Enter your Gender: '),nl,
read(G), (riskgender(G)-> nl,write('Gender already recorded');
assert(riskgender(G)),nl,write('Gender successfully recorded')).

get_riskind:- nl, write('Enter your Body Mass Index (BMI): '),nl,
read(Index), (riskindex(Index)-> nl,write('BMI already recorded');
assert(riskindex(Index)),nl,write('BMI successfully recorded')),nl,nl,write('Would you like to enter another record (y/n)?'), nl, read(Option),
(Option== y ->get_riskethnicity,get_riskgender,get_riskind; get_choice).


% code for survey

survey:- get_gender(Gendrisk), get_ethnicity(Ethrisk), get_features(Bmirisk), calcrisk(Gendrisk,Ethrisk,Bmirisk,Risklevel), diagnosis(Risklevel), get_choice.


get_gender(Gendrisk):- nl, write('What is your gender?'), nl, read(Gender),(riskgender(Gender) -> Gendrisk is 1; Gendrisk is 0) .


get_ethnicity(Ethrisk):- nl, write('What is your Ethnicity?'), nl, read(E),
(riskethnicity(E) -> Ethrisk is 1; Ethrisk is 0).


get_features(Bmirisk):- nl, write('---------Height Info-----------'),nl, write('Feet: '), nl,read(Ft), nl, write('Inches: '), nl, read(Inch), nl, write('Enter your weight in pounds: '), nl, read(Weight),bmi(Ft,Inch,Weight,Bmirisk).


bmi(Feet,Inch,Wt,Bmirisk):- B is ((Wt*0.453592) / (((Feet*0.3048)+(Inch*0.0254))* ((Feet*0.3048)+(Inch*0.0254)))), riskindex(Bmival),(B>Bmival-> Bmirisk is 1; Bmirisk is 0),obesitydiagnosis(B).


obesitydiagnosis(B):- (B > 25), nl, write('You are overweight'); nl,  write('Your weight is normal.').

calcrisk(Gendrisk,Ethrisk,Bmirisk,Risklevel):- Risk  is (Gendrisk+Ethrisk+Bmirisk),
        ((Risk>1) -> (Risklevel = high); Risklevel = low), bp(Risk).

bp(Rsk):- (Rsk>1),nl, nl, write('Enter your systolic blood pressure: '), nl, read(Sys), nl, nl, write('Enter your diastolic blood pressure: '),nl, read(Dia), calcbp(Sys, Dia); nl.

calcbp(S,D):- nl,( (S>120; D>80) -> write('You have an elevated blood pressure');  write('Your blood pressure is normal')).

diagnosis(Risklevel) :- nl, write('Your risk of having hypertension is '), write(Risklevel).

