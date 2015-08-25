SELECT 
  proposal_type.name, 
  person.email_address, 
  person.firstname
FROM 
  public.proposal, 
  public.proposal_type, 
  public.person_proposal_map, 
  public.person
WHERE 
  proposal_type.id = proposal.proposal_type_id AND
  person_proposal_map.proposal_id = proposal.id AND
  person.id = person_proposal_map.person_id;
