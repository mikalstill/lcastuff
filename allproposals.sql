SELECT 
  proposal.id AS proposal_id, 
  proposal.title, 
  person.firstname, 
  person.lastname,
  person.email_address,
  proposal_type.name AS type, 
  proposal_status.name
FROM 
  public.proposal, 
  public.person, 
  public.person_proposal_map, 
  public.proposal_type, 
  public.proposal_status
WHERE 
  person_proposal_map.person_id = person.id AND
  person_proposal_map.proposal_id = proposal.id AND
  proposal_type.id = proposal.proposal_type_id AND
  proposal_status.id = proposal.status_id;
