<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="dir_app_group_info.subsite_p_1">      
      <querytext>
      
        select * from (
          select object_id as subsite_id
            from site_nodes n
           where (select package_key from apm_packages p where p.package_id = n.object_id) = 'acs-subsite' 
         connect by node_id = prior parent_id 
           start with node_id = :node_id 
           order by level
        ) where rownum = 1
    
      </querytext>
</fullquery>

 
<fullquery name="dir_app_group_info.subsite_p_2">      
      <querytext>
      
          select object_id as subsite_id, acs_object.name(object_id) as subsite_name
            from site_nodes n
           where (select package_key from apm_packages p where p.package_id = n.object_id) = 'acs-subsite' 
         connect by node_id = prior parent_id 
           start with node_id = :node_id 
           order by level
    
      </querytext>
</fullquery>

 
</queryset>
