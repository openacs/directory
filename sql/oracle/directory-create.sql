--
-- packages/directory/sql/directory-create.sql
--
-- @author mikeb@arsdigita.com
-- @creation-date 2001-04-16
-- @cvs-id $Id$
--

-- call this view using "and group_id = :application_group_id"
-- to find all members of an application_group
create or replace view dir_group_members as
   select p.party_id as user_id, p.email, pe.first_names, pe.last_name, p.url, r.object_id_one as group_id
     from parties p, persons pe, acs_rels r
    where p.party_id = pe.person_id
      and p.party_id = r.object_id_two
      and r.rel_type = 'membership_rel';

-- call this view using "and subsite_id = :subsite_id"
-- to find all members of a subsite
create or replace view dir_subsite_members as
   select m.*, g.package_id as subsite_id
     from dir_group_members m,
          application_groups g
    where g.group_id = m.group_id;

-- view to display all registered users 
-- (the ACS registered_users view is slower, and retrieves a lot of information that we don't need)
create or replace view dir_all_users as
   select p.party_id as user_id, p.email, pe.first_names, pe.last_name, p.url
     from parties p, persons pe
    where p.party_id = pe.person_id;


