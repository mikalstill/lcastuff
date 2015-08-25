SELECT 
  review.proposal_id, 
  avg(review.score), 
  travel_assistance_type.name, 
  person.firstname, 
  person.lastname, 
  person.city, 
  person.state, 
  person.country
FROM 
  public.review, 
  public.proposal, 
  public.travel_assistance_type, 
  public.person, 
  public.person_proposal_map
WHERE 
  proposal.id = review.proposal_id AND
  travel_assistance_type.id = proposal.travel_assistance_type_id AND
  person_proposal_map.proposal_id = proposal.id AND
  person_proposal_map.person_id = person.id AND
  score IS NOT NULL
GROUP BY
  review.proposal_id,
  travel_assistance_type.name, 
  person.firstname, 
  person.lastname, 
  person.city, 
  person.state, 
  person.country;
