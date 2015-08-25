SELECT 
  review.proposal_id, 
  review.score, 
  review.comment, 
  review.private_comment, 
  review.creation_timestamp, 
  review.last_modification_timestamp, 
  person.firstname AS reviewer_firstname, 
  person.lastname AS reviewer_lastname
FROM 
  public.review, 
  public.person
WHERE 
  review.reviewer_id = person.id;
