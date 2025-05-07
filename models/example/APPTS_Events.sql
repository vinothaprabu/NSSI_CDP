
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='incremental') }}

with source_data as (

 SELECT 
    ROW_NUMBER() OVER (ORDER BY File_Number) AS sequence_id,
    e.File_Number,
    e.Job_Code,
    e.Job_Type,
    e.Start_Date,
    e.End_Date,
    e.Supervisor_Number,
    e.OU_Code,
    a.appt_reference_no,
    a.interview_type_id,
    a.int_description,
    a.scheduled_date,
    a.scheduled_start_time,
    a.scheduled_end_time
FROM `inbound-stage-458010-t2.HRDATA_FDP.EMPLOYEES_DATA` AS e
JOIN `inbound-stage-458010-t2.APBS_FDP.APPTS_DATA` AS a
ON CAST(e.File_Number AS STRING) = a.maker_id

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
