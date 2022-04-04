select cl.client_id,  
coalesce(to_char(to_date(birth_dt, 'DDMONYYYY:HH24:MI:SS', 'NLS_DATE_LANGUAGE = American')), 'Нет данных') as birth_dt,
coalesce(floor(months_between('01.12.2021',to_date(birth_dt, 'DDMONYYYY:HH24:MI:SS', 'NLS_DATE_LANGUAGE = American'))/12),0) as age, 
coalesce(cl.region_code,0) as region_code, ad.region||
    (case when ad.region_type is not null then ' '||ad.region_type else ',' end)||
    (case when ad.district is not null then ', '||ad.district else '' end)||
    (case when ad.district_type is not null then ' '||ad.district_type else '' end)||
    (case when ad.city_type is not null then ', '||ad.city_type else '' end)||
    (case when ad.city is not null then ' '||ad.city else '' end)||
    (case when ad.town_type is not null then ', '||ad.town_type else '' end)||
    (case when ad.town is not null then ' '||ad.town else '' end) as reg_addr,
ad2.region||
    (case when ad2.region_type is not null then ' '||ad2.region_type else ',' end)||
    (case when ad2.district is not null then ', '||ad2.district else '' end)||
    (case when ad2.district_type is not null then ' '||ad2.district_type else '' end)||
    (case when ad2.city_type is not null then ', '||ad2.city_type else '' end)||
    (case when ad2.city is not null then ' '||ad2.city else '' end)||
    (case when ad2.town_type is not null then ', '||ad2.town_type else '' end)||
    (case when ad2.town is not null then ' '||ad2.town else '' end) as fact_addr,
coalesce(gen.gender_nm,'Нет данных')as gender_nm, 
coalesce(edu.level_nm,'Нет данных') as education_level_nm,
coalesce(fam.status_nm,'Нет данных') as family_status_nm,
coalesce(cl.fullseniority_year_cnt,0) as fullseniority_year_cnt,
coalesce(round(cl.fullseniority_year_cnt/
floor(months_between('01.12.2021',to_date(birth_dt, 'DDMONYYYY:HH24:MI:SS', 'NLS_DATE_LANGUAGE = American'))/12),2),0) 
as work_part_of_life_pct,
coalesce(cl.staff_flg,'0') as staff_flg,
extract(year from date '2021-12-01')-cl.name_change_year as last_nm_change_year_cnt,
coalesce(app_hist_cnt,0) as app_hist_cnt,
coalesce(app_6m_cnt,0) as app_6m_cnt,
coalesce(app_3m_cnt,0) as app_3m_cnt,
coalesce(app_hist_amt,0) as app_hist_amt,
coalesce(app_6m_amt,0) as app_6m_amt,
coalesce(app_3m_amt,0) as app_3m_amt,
coalesce(mortgage_6m_flg,0) as mortgage_6m_flg,
coalesce(max_cur_delq_bucket,'0') as max_cur_delq_bucket,
coalesce(delq_1_30_3m_flg,'0') as delq_1_30_3m_flg,
coalesce(delq_1_30_6m_flg,'0') as delq_1_30_6m_flg,
coalesce(delq_90_12m_flg,'0') as delq_90_12m_flg,
coalesce(last_agr_less6m_flg,'0') as last_agr_less6m_flg,
coalesce(last_open_agr_month_cnt,0) as last_open_agr_month_cnt,
coalesce(first_open_agr_month_cnt,0) as first_open_agr_month_cnt,
coalesce(max_close_agr_now_month_cnt,0) as max_close_agr_now_month_cnt,
coalesce(current_credit_limit_amt,0) as current_credit_limit_amt,
coalesce(current_curr_balance_amt,0) as current_curr_balance_amt,
coalesce(trans_out_30d_amt,0) as trans_out_30d_amt,
coalesce(trans_out_90d_amt,0) as trans_out_90d_amt,
coalesce(trans_out_180d_amt,0) as trans_out_180d_amt,
coalesce(trans_out_365d_amt,0) as trans_out_365d_amt,
coalesce(trans_in_30d_amt,0) as trans_in_30d_amt,
coalesce(trans_in_90d_amt,0) as trans_in_90d_amt,
coalesce(trans_in_180d_amt,0) as trans_in_180d_amt,
coalesce(trans_in_365d_amt,0) as trans_in_365d_amt,
coalesce(trans_all_30d_amt,0) as trans_all_30d_amt,
coalesce(trans_all_90d_amt,0) as trans_all_90d_amt,
coalesce(trans_all_180d_amt,0) as trans_all_180d_amt,
coalesce(trans_all_365d_amt,0) as trans_all_365d_amt,
coalesce(last_month_to_avg3m_sum_pct,0) as last_month_to_avg3m_sum_pct,
coalesce(last_month_to_avg6m_sum_pct,0) as last_month_to_avg6m_sum_pct,
coalesce(last_month_to_avg12m_sum_pct,0) as last_month_to_avg12m_sum_pct,
coalesce(avg3m_to_avg6m_sum_pct,0) as avg3m_to_avg6m_sum_pct,
coalesce(last_month_to_avg3m_cnt_pct,0) as last_month_to_avg3m_cnt_pct,
coalesce(last_month_to_avg6m_cnt_pct,0) as last_month_to_avg6m_cnt_pct,
coalesce(last_month_to_avg12m_cnt_pct,0) as last_month_to_avg12m_cnt_pct,
coalesce(avg3m_to_avg6m_cnt_pct,0) as avg3m_to_avg6m_cnt_pct,
coalesce(salary_2m_amt,0) as salary_2m_amt, 
coalesce(salary_1m_amt,0) as salary_1m_amt,
coalesce(salary_3m_amt,0) as salary_3m_amt,
coalesce(salary_4m_amt,0) as salary_4m_amt,
coalesce(salary_5m_amt,0) as salary_5m_amt,
coalesce(salary_6m_amt,0) as salary_6m_amt,
coalesce(salary_1m_cnt,0) as salary_1m_cnt,
coalesce(salary_2m_cnt,0) as salary_2m_cnt,
coalesce(salary_3m_cnt,0) as salary_3m_cnt,
coalesce(salary_4m_cnt,0) as salary_4m_cnt,
coalesce(salary_5m_cnt,0) as salary_5m_cnt,
coalesce(salary_6m_cnt,0) as salary_6m_cnt,
coalesce(salary_1m_to_3m_amt_pct,0) as salary_1m_to_3m_amt_pct,
coalesce(salary_1m_to_6m_cnt_pct,0) as salary_1m_to_6m_cnt_pct,
coalesce(salary_during_6m_cnt,0) as salary_during_6m_cnt,
coalesce(last_sal_trans_month_cnt,0) as last_sal_trans_month_cnt,
coalesce(first_sal_trans_month_cnt,0) as first_sal_trans_month_cnt

from DE_COMMON.GROUP_DIM_CLIENT cl
left join DE_COMMON.GROUP_DIM_CLIENT_ADDRESS ad
on cl.client_id = ad.client_id
left join DE_COMMON.GROUP_DICT_ADDRESS_TYPE adt
on ad.addr_type = adt.address_code
left join DE_COMMON.GROUP_DIM_CLIENT_ADDRESS ad2
on ad.client_id = ad2.client_id
left join DE_COMMON.GROUP_DICT_ADDRESS_TYPE adt2
on ad2.addr_type = adt2.address_code
left join DE_COMMON.GROUP_DICT_GENDER gen
on cl.gender_code = gen.gender_code
left join DE_COMMON.GROUP_DICT_EDUCATION_LEVEL edu 
on cl.education_level_code = edu.level_code
left join DE_COMMON.GROUP_DICT_FAMILY_STATUS fam
on cl.family_status_code = fam.status_code
left join
    (select client_id,
    coalesce(count(application_date),0) as app_hist_cnt,
    coalesce(count(case 
        when application_date between(add_months('01.12.2021', -6)) and '01.12.2021' then 1 
        else null
        end),0) as app_6m_cnt,
    coalesce(count(case 
        when application_date between(add_months('01.12.2021', -3)) and '01.12.2021' then 1 
        else null
        end),0) as app_3m_cnt,
    coalesce(sum(agreement_sum_amt),0) as app_hist_amt,
    coalesce(sum(case when application_date between (add_months('01.12.2021', -6)) and '01.12.2021' then agreement_sum_amt
        else 0 
        end),0) as app_6m_amt,
    coalesce(sum(case when application_date between (add_months('01.12.2021', -3)) and '01.12.2021' then agreement_sum_amt
        else 0 
        end),0) as app_3m_amt,
    max(case 
        when cr_dict.product_nm = 'Ипотека' and
        (application_date between (add_months('01.12.2021', -6)) and '01.12.2021') then 1
        else 0
        end) mortgage_6m_flg,
    floor(months_between('01.12.2021',max(application_date))) as last_app_month_cnt
    from 
    DE_COMMON.GROUP_FCT_CREDIT_APPLICATIONS cr_app
    left join DE_COMMON.GROUP_DICT_CREDIT_PRODUCT cr_dict
    on cr_app.credit_product_type = cr_dict.poduct_type
    where application_date < '01.12.2021'
    group by client_id 
    ) block2 
    on cl.client_id = block2.client_id   
left join(
select client_id,
case
    when max_cur_delq_bucket_num = '5' then '120+'
    when max_cur_delq_bucket_num = '4' then '[90-120)'
    when max_cur_delq_bucket_num = '3' then '[60-90)'
    when max_cur_delq_bucket_num = '2' then '[30-60)'
    when max_cur_delq_bucket_num = '1' then '[1-30)'
    else '0'
    end max_cur_delq_bucket,
    delq_1_30_3m_flg,
    delq_1_30_6m_flg,
    delq_90_12m_flg,
    last_agr_less6m_flg,
    last_open_agr_month_cnt,
    first_open_agr_month_cnt,
    max_close_agr_now_month_cnt,
    current_credit_limit_amt,
    current_curr_balance_amt
from
    (select client_id, 
    max(case  
        when pmt_string_84m_2 in ('X','0','1') then '0'
        when pmt_string_84m_2 in ('A','E','F') then '1'
        else pmt_string_84m_2
        end) max_cur_delq_bucket_num,
        max(case 
        when regexp_like(pmt_string_84m_3m,'[EAF]') then '1'
        else '0'
        end) delq_1_30_3m_flg,
        max(case 
        when regexp_like(pmt_string_84m_6m,'[EAF]') then '1'
        else '0'
        end) delq_1_30_6m_flg,
        max(case 
        when regexp_like(pmt_string_84m_12m,'[4-5]') then '1'
        else '0'
        end) delq_90_12m_flg,
        max(case
        when to_date(open_dt, 'DDMONYYYY:HH24:MI:SS') > add_months(report_dt,-6) then '1'
        else '0'
        end) last_agr_less6m_flg,
        max(floor(months_between(report_dt,(to_date(open_dt, 'DDMONYYYY:HH24:MI:SS')))))
        as last_open_agr_month_cnt,
        min(floor(months_between(report_dt,(to_date(open_dt, 'DDMONYYYY:HH24:MI:SS'))))) 
        as first_open_agr_month_cnt,
        floor(months_between(max(to_date((substr(plan_close_dt,1,9)),'DD-MON-YY')),max(report_dt)))
        as max_close_agr_now_month_cnt,
        sum(dolg) as current_credit_limit_amt,
        sum(limit) as current_curr_balance_amt
            from
            (select bki.*, 
			--Логика при подсчете была такая,что дата первого знака в pmt_string_84m справа это дата pmt_string_start_dt, далее количество знаков должно быть равно кол-ву месяцев до отчетной даты.
            substr(lpad(pmt_string_84m, months_between(report_dt,trunc(to_date(pmt_string_start_dt, 'DDMONYYYY:HH24:MI:SS'),'MM')),'0'),1,1) 
            as pmt_string_84m_2,
            substr(lpad(pmt_string_84m, months_between(report_dt,trunc(to_date(pmt_string_start_dt, 'DDMONYYYY:HH24:MI:SS'),'MM')),'0'),1,3) 
            as pmt_string_84m_3m,
            substr(lpad(pmt_string_84m, months_between(report_dt,trunc(to_date(pmt_string_start_dt, 'DDMONYYYY:HH24:MI:SS'),'MM')),'0'),1,6) 
            as pmt_string_84m_6m,
            substr(lpad(pmt_string_84m, months_between(report_dt,trunc(to_date(pmt_string_start_dt, 'DDMONYYYY:HH24:MI:SS'),'MM')),'0'),1,12) 
            as pmt_string_84m_12m,
            case 
            when fact_close_dt is null then curr_balance_amt
            else 0 
            end dolg,
            case 
            when fact_close_dt is null then credit_limit_amt
            else 0 
            end limit
            from DE_COMMON.GROUP_REP_BKI_INFO bki)
group by client_id)) block3
on cl.client_id = block3.client_id
left join(
    select client_id,
    sum(out_30) as trans_out_30d_amt,
    sum(out_90) as trans_out_90d_amt,
    sum(out_180) as trans_out_180d_amt,
    sum(out_365) as trans_out_365d_amt,
    sum(in_30) as trans_in_30d_amt,
    sum(in_90) as trans_in_90d_amt,
    sum(in_180) as trans_in_180d_amt,
    sum(in_365) as trans_in_365d_amt,
    sum(out_30) + sum(in_30) as trans_all_30d_amt,
    sum(out_90) + sum(in_90) as trans_all_90d_amt,
    sum(out_180) + sum(in_180) as trans_all_180d_amt,
    sum(out_365) + sum(in_365) as trans_all_365d_amt,
    round((sum(trans_last1)) / ((sum(trans_last3))/3),2) as last_month_to_avg3m_sum_pct,
    round((sum(trans_last1)) / ((sum(trans_last6))/6),2) as last_month_to_avg6m_sum_pct,
    round((sum(trans_last1)) / ((sum(trans_last12))/12),2) as last_month_to_avg12m_sum_pct,
    round(((sum(trans_last3))/3) / ((sum(trans_last6))/6),2) as avg3m_to_avg6m_sum_pct,
    round((count(trans_last1)) / (count(trans_last3)/3),2) as last_month_to_avg3m_cnt_pct,
    round((count(trans_last1)) / (count(trans_last6)/6),2) as last_month_to_avg6m_cnt_pct,
    round((count(trans_last1)) / (count(trans_last12)/12),2) as last_month_to_avg12m_cnt_pct,
    round((count(trans_last3)/3) / (count(trans_last6)/6),2) as avg3m_to_avg6m_cnt_pct
    from
        (select tr.*, 
        case when (transaction_dt between to_date('01.12.2021')-30 and to_date('01.12.2021')-1) and (in_out_type ='OUT')
        then trans_amt else 0
        end out_30,
        case when (transaction_dt between to_date('01.12.2021')-90 and to_date('01.12.2021')-1) and (in_out_type ='OUT') 
        then trans_amt else 0
        end out_90,
        case when (transaction_dt between to_date('01.12.2021')-180 and to_date('01.12.2021')-1) and (in_out_type ='OUT')
        then trans_amt else 0
        end out_180,
        case when (transaction_dt between to_date('01.12.2021')-365 and to_date('01.12.2021')-1) and (in_out_type ='OUT') 
        then trans_amt else 0
        end out_365,
        case when (transaction_dt between to_date('01.12.2021')-30 and to_date('01.12.2021')-1) and (in_out_type ='IN') 
        then trans_amt else 0
        end in_30,
        case when (transaction_dt between to_date('01.12.2021')-90 and to_date('01.12.2021')-1) and (in_out_type ='IN')
        then trans_amt else 0
        end in_90,
        case when (transaction_dt between to_date('01.12.2021')-180 and to_date('01.12.2021')-1) and (in_out_type ='IN') 
        then trans_amt else 0
        end in_180,
        case when (transaction_dt between to_date('01.12.2021')-365 and to_date('01.12.2021')-1) and (in_out_type ='IN')
        then trans_amt else 0
        end in_365,
        case when transaction_dt between add_months(to_date('01.12.2021'),-1) and to_date('01.12.2021') 
        then trans_amt else null
        end trans_last1,
        case when transaction_dt between add_months(to_date('01.12.2021'),-3) and to_date('01.12.2021')
        then trans_amt else null
        end trans_last3,
        case when transaction_dt between add_months(to_date('01.12.2021'),-6) and to_date('01.12.2021') 
        then trans_amt else null
        end trans_last6,
        case when transaction_dt between add_months(to_date('01.12.2021'),-12) and to_date('01.12.2021')
        then trans_amt else null
        end trans_last12
            from DE_COMMON.GROUP_FCT_TRANSACTIONS tr
            where oper_result = 'SUCCESS')
            group by client_id) block4
    on cl.client_id = block4.client_id   
left join(
        select client_id, coalesce(sum(mon_1),0) as salary_2m_amt, coalesce(sum(mon_2),0) as salary_1m_amt, coalesce(sum(mon_3),0) as salary_3m_amt,
    coalesce(sum(mon_4),0) as salary_4m_amt, coalesce(sum(mon_5),0) as salary_5m_amt, coalesce(sum(mon_6),0) as salary_6m_amt, 
    count(mon_1) as salary_1m_cnt,
    count(mon_2) as salary_2m_cnt,
    count(mon_3) as salary_3m_cnt,
    count(mon_4) as salary_4m_cnt,
    count(mon_5) as salary_5m_cnt,
    count(mon_6) as salary_6m_cnt ,
    round(coalesce(sum(mon_1),0) / (coalesce(sum(mon_1),0) + coalesce(sum(mon_2),0) +  coalesce(sum(mon_3),0)),2) 
    as salary_1m_to_3m_amt_pct,
    round(coalesce(sum(mon_1),0) / (coalesce(sum(mon_1),0) + coalesce(sum(mon_2),0) +  coalesce(sum(mon_3),0) 
    + coalesce(sum(mon_4),0) + coalesce(sum(mon_5),0) + coalesce(sum(mon_6),0)),2)
    as salary_1m_to_6m_amt_pct,
    round(count(mon_1) / (count(mon_1) + count(mon_2) + count(mon_3)),2) as salary_1m_to_3m_cnt_pct,
    round(count(mon_1) / (count(mon_1) + count(mon_2) + count(mon_3) + count(mon_4) + count(mon_5) + count(mon_5)),2) 
    as salary_1m_to_6m_cnt_pct,
    max(cnt_mon_last6) as salary_during_6m_cnt,
    months_between('01.12.2021',max(to_date(rpad(income_month,10,'-01'),'YYYY-MM-DD'))) as last_sal_trans_month_cnt,
    months_between('01.12.2021',min(to_date(rpad(income_month,10,'-01'),'YYYY-MM-DD'))) as first_sal_trans_month_cnt
    from
        (select fct.*,
        case when substr(fct.income_month,-2) = extract(month from(add_months(to_date('01.12.2021'),-1)))
        then fct.income_sum_amt else null
        end mon_1,
        case when substr(fct.income_month,-2) = extract(month from(add_months(to_date('01.12.2021'),-2)))
        then fct.income_sum_amt else null
        end mon_2,
        case when substr(fct.income_month,-2) = extract(month from(add_months(to_date('01.12.2021'),-3)))
        then fct.income_sum_amt else null
        end mon_3,
        case when substr(fct.income_month,-2) = extract(month from(add_months(to_date('01.12.2021'),-4)))
        then fct.income_sum_amt else null
        end mon_4,
        case when substr(fct.income_month,-2) = extract(month from(add_months(to_date('01.12.2021'),-5)))
        then fct.income_sum_amt else null
        end mon_5,
        case when substr(fct.income_month,-2) = extract(month from(add_months(to_date('01.12.2021'),-6)))
        then fct.income_sum_amt else null
        end mon_6,
        dense_rank() over(partition by fct.client_id order by fct2.income_month) as cnt_mon_last6
        from DE_COMMON.GROUP_FCT_INCOME_TRANSACTIONS fct
        left join DE_COMMON.GROUP_DICT_INCOME_TYPE dic
        on fct.income_type = dic.income_type
        left join DE_COMMON.GROUP_FCT_INCOME_TRANSACTIONS fct2
        on fct.client_id = fct2.client_id 
        and fct2.income_month between '2021-06' and '2021-11'
        where income_nm = 'Зарплатное начисление'
        and fct.income_month < '2021-12')
    group by client_id) block5
    on cl.client_id = block5.client_id
where adt.address_nm = 'Адрес постоянной регистрации' and adt2.address_nm = 'Фактический адрес';
