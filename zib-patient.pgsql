select json_agg(t)
from(
	SELECT concat('BMP.', patient.id)::text as "id",
	patient.nhs_number as "identifier.value",
	concat(split_part(patient.other_names, '. ', 2), ' ', patient.Name) as "name.family",
	patient.Name as "_family.extension.own-name.valueString",
	split_part(patient.other_names, '. ', 2) as "_family.extension.own-prefix.valueString",
	--patient.gender as "gender",
	patient.dob as "birthDate"
	FROM public.patient
	inner join   episode
	ON episode.patient = patient.id
	inner join   exam
	ON exam.episode = episode.id
	where exam.us_date >= CURRENT_DATE - 260
	limit 100
)t
