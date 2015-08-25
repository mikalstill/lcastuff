#!/usr/bin/python

# A quick and dirty script to notify people when their review is outdated
# because the speaker tweaked their talk proposal.

import csv
import os
import smtplib
import sys
import time

from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

for row in csv.DictReader(open('outdatedreviews.csv'), delimiter=';'):
    unique = '%s-%s-%s' %(row['proposal_id'], row['proposal_timestamp'],
                          row['reviewer_email'])
    unique = unique.replace(' ', '_')
    unique = unique.replace('@', '_at_')
    state_path = os.path.join('outdatedreviews-state', unique)

    if os.path.exists(state_path):
        continue

    if row['proposal_type'] == 'Miniconf':
        continue

    if not row['reviewer_comment']:
        row['reviewer_comment'] = '*none*'
    if not row['reviewer_private_comment']:
        row['reviewer_private_comment'] = '*none*'

    recipients = [row['reviewer_email'], 'papers-chair@lca2013.linux.org.au']
    # recipients = ['mikal@lca2013.linux.org.au']
    body = """Hi.

This is an email from a steam driven python script which has noticed that a speaker has updated their proposal since you reviewed it. It might be worth reconsidering your review.

Specifically:
  id: %(proposal_id)s
  title: %(proposal_title)s
  type: %(proposal_type)s
  url: https://lca2013.linux.org.au/proposal/%(proposal_id)s/review

Was updated on %(proposal_timestamp)s, but you reviewed it on %(review_timestamp)s. When you previously reviewed it *you gave a score of %(reviewer_score)s* with the following comments (if any):

Public comment
==============

%(reviewer_comment)s

Private comment
===============

%(reviewer_private_comment)s

***

Have a nice life.
""" % row

    msg = MIMEMultipart()
    msg['Subject'] = ('LCA2013 outdated review: proposal %s "%s"'
                      %(row['proposal_id'], row['proposal_title']))
    msg['From'] = 'mikal@lca2013.linux.org.au'
    msg['To'] = ', '.join(recipients)
    msg.preamble = body

    txt = MIMEText(body, 'plain')
    msg.attach(txt)

    s = smtplib.SMTP('192.168.1.14')
    s.sendmail('mikal@lca2013.linux.org.au', recipients, msg.as_string())
    s.quit()
    print 'Emailed proposal %s to %s' %(row['proposal_id'],
                                        row['reviewer_email'])

    f = open(state_path, 'w')
    f.write('%s' % time.time())
    f.close()
