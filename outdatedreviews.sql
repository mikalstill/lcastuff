SELECT 
  proposal.id AS proposal_id, 
  proposal.title AS proposal_title, 
  proposal.last_modification_timestamp AS proposal_timestamp, 
  review.last_modification_timestamp AS review_timestamp, 
  person.email_address AS reviewer_email, 
  review.score AS reviewer_score, 
  review.comment AS reviewer_comment, 
  review.private_comment AS reviewer_private_comment, 
  proposal_type.name AS proposal_type
FROM 
  public.proposal, 
  public.review, 
  public.person, 
  public.proposal_type
WHERE 
  review.proposal_id = proposal.id AND
  person.id = review.reviewer_id AND
  proposal_type.id = proposal.proposal_type_id AND
  review.last_modification_timestamp < proposal.last_modification_timestamp;
