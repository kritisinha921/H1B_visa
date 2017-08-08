h1b = LOAD '/home/hduser/h1b_final' USING PigStorage('\t') AS (s_no:int,case_status, employer_name, soc_name, job_title, full_time_position ,prevailing_wage:int,year, worksite, longitute:double, latitute:double);

filt = filter h1b by job_title == 'DATA ENGINEER';
filt0 = filter filt by case_status == 'CERTIFIED';
filt1 = filter filt0 by year == '2011';
yearwise1 = foreach filt1 generate soc_name, worksite;
groupby1 = group yearwise1 by worksite;
count1 = foreach groupby1 generate $0, COUNT(yearwise1.soc_name);
odr1 = order count1 by $1 desc;
limit1 = limit odr1 1;
final1 = foreach limit1 generate $0, $1, '2011' as year;


filt2 = filter filt0 by year == '2012';
yearwise2 = foreach filt2 generate soc_name, worksite;
groupby2 = group yearwise2 by worksite;
count2 = foreach groupby2 generate $0, COUNT(yearwise2.soc_name);
odr2 = order count2 by $1 desc;
limit2 = limit odr2 1;
final2 = foreach limit2 generate $0, $1, '2012' as year;

filt3 = filter filt0 by year == '2013';
yearwise3 = foreach filt3 generate soc_name, worksite;
groupby3 = group yearwise3 by worksite;
count3 = foreach groupby3 generate $0, COUNT(yearwise3.soc_name);
odr3 = order count3 by $1 desc;
limit3 = limit odr3 1;
final3 = foreach limit3 generate $0, $1, '2013' as year;

filt4 = filter filt0 by year == '2014';
yearwise4 = foreach filt4 generate soc_name, worksite;
groupby4 = group yearwise4 by worksite;
count4 = foreach groupby4 generate $0, COUNT(yearwise4.soc_name);
odr4 = order count4 by $1 desc;
limit4 = limit odr4 1;
final4 = foreach limit4 generate $0, $1, '2014' as year;

filt5 = filter filt0 by year == '2015';
yearwise5 = foreach filt5 generate soc_name, worksite;
groupby5 = group yearwise5 by worksite;
count5 = foreach groupby5 generate $0, COUNT(yearwise5.soc_name);
odr5 = order count5 by $1 desc;
limit5 = limit odr5 1;
final5 = foreach limit1 generate $0, $1, '2015' as year;

filt6 = filter filt0 by year == '2016';
yearwise6 = foreach filt6 generate soc_name, worksite;
groupby6 = group yearwise6 by worksite;
count6 = foreach groupby6 generate $0, COUNT(yearwise6.soc_name);
odr6 = order count6 by $1 desc;
limit6 = limit odr6 1;
final6 = foreach limit6 generate $0, $1, '2016' as year;

joined = UNION final1, final2, final3, final4, final5, final6;
odr = order joined by $2;
store odr into '/home/hduser/que2a' using PigStorage(',');

