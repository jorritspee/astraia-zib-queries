select json_agg(t)
from(
	SELECT concat('BMP.epi.', episode.id) as "id",
	'active' as "status",
	'to do: welke diagnoses?' as "diagnosis.condition",
	concat('BMP.pat.', patient.id)::text as "patientid",
	'fixed: BMP' as "managingOrganization"
	FROM public.patient
	inner join   episode
	ON episode.patient = patient.id
	inner join   exam
	ON exam.episode = episode.id
	where exam.us_date >= CURRENT_DATE - 260
	limit 100
)t
