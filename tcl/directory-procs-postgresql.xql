<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="dir_app_group_info.subsite_p">      
      <querytext>
    
         select s2.object_id as subsite_id, tree_level(s2.tree_sortkey) as level
         from site_nodes s1, site_nodes s2, apm_packages p
         where s1.node_id = :node_id
            and s2.tree_sortkey <= s1.tree_sortkey
            and s1.tree_sortkey like (s2.tree_sortkey || '%')
            and p.package_id = s2.object_id and p.package_key = 'acs-subsite'
         order by level
         limit 1

      </querytext>
</fullquery>
 
</queryset>
