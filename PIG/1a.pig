h1b = LOAD '/home/hduser/h1b_final' USING PigStorage('\t') AS
(s_no:int,case_status, employer_name, soc_name, job_title, full_time_position ,prevailing_wage:int,year, worksite, longitute:double, latitute:double);

filt = filter h1b by job_title == 'DATA ENGINEER';

filt1 = foreach filt generate soc_name, year;
groupby = group filt1 by $1;
count = foreach groupby generate $0, COUNT(filt1.soc_name);

split count into bag1 if $0 == 2011,bag2 if $0 == 2012,bag3 if $0 == 2013,bag4 if $0 == 2014,bag5 if $0 == 2015,bag6 if $0 == 2016;

bag7 = foreach bag1 generate $0,$1, '1' as s_no;
bag8 = foreach bag2 generate $0,$1, '1' as s_no;
bag9 = foreach bag3 generate $0,$1, '1' as s_no;
bag10 = foreach bag4 generate $0,$1, '1' as s_no;
bag11 = foreach bag5 generate $0,$1, '1' as s_no;
bag12 = foreach bag6 generate $0,$1, '1' as s_no;
joined = join bag7 by $2, bag8 by $2, bag9 by $2,bag10 by $2,bag11 by $2,bag12 by $2;

growth = foreach joined generate ROUND_TO(((float)($4-$1)/$1*100),2) , ROUND_TO(((float)($7-$4)/$4*100),2) , ROUND_TO(((float)($10-$7)/$7*100),2) , ROUND_TO(((float)($13-$10)/$10*100),2) , ROUND_TO(((float)($16-$13)/$13*100),2);
avg_growth = foreach growth generate ($0+$1+$2+$3+$4)/5;
dump avg_growth;

--(71.926)

