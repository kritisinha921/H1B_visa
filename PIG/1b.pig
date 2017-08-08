h1b = LOAD '/home/hduser/h1b_final' USING PigStorage('\t') AS
(s_no:int,case_status, employer_name, soc_name, job_title, full_time_position ,prevailing_wage:int,year, worksite, longitute:double, latitute:double);

noheader= filter h1b by $0>=1;
limit1 = limit noheader 5;
filt1 = filter noheader  by $7 matches '2011'; 
group1 = group filt1 by $4 ;								
count1 = foreach group1 generate group,COUNT($1);

filt2 = filter noheader  by $7 matches '2012'; 
group2 = group filt2 by $4 ;								
count2 = foreach group2 generate group,COUNT($1);

filt3 = filter noheader  by $7 matches '2013'; 
group3 = group filt3 by $4 ;								
count3 = foreach group3 generate group,COUNT($1);

filt4 = filter noheader  by $7 matches '2014'; 
group4 = group filt4 by $4 ;								
count4 = foreach group4 generate group,COUNT($1);

filt5 = filter noheader  by $7 matches '2015'; 
group5 = group filt5 by $4 ;								
count5 = foreach group5 generate group,COUNT($1);

filt6 = filter noheader  by $7 matches '2016'; 
group6 = group filt6 by $4 ;								
count6 = foreach group6 generate group,COUNT($1);

joined= join count1 by $0,count2 by $0,count3 by $0,count4 by $0,count5 by $0,count6 by $0;
yearwise= foreach joined generate $0,$1,$3,$5,$7,$9,$11;

growth= foreach yearwise  generate $0,
(float)($6-$5)*100/$5,(float)($5-$4)*100/$4,
(float)($4-$3)*100/$3,(float)($3-$2)*100/$2,
(float)($2-$1)*100/$1;

avg_growth= foreach growth generate $0,($1+$2+$3+$4+$5)/5;
odr = order avg_growth by $1 desc;
final = limit odr  5;
--dump final;

store final into '/home/hduser/que1b' using PigStorage(',');

