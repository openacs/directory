<?xml version="1.0"?>
<queryset>

<fullquery name="dir_alpha_nav_bar.initial_list">      
      <querytext>
      
	select distinct upper(substr(last_name,1,1)) 
          from $table_and_group
      </querytext>
</fullquery>

 
<fullquery name="dir_app_group_info.n_id">      
      <querytext>
      
        select node_id from site_nodes
        where object_id = :package_id
    
      </querytext>
</fullquery>

 
<fullquery name="dir_app_group_info.g_i">      
      <querytext>
      
      select g.group_id, g.group_name
        from groups g, application_groups a
       where a.package_id = :subsite_id
         and a.group_id = g.group_id
    
      </querytext>
</fullquery>

 
<fullquery name="dir_subsite_info.n_id">      
      <querytext>
      
        select node_id from site_nodes
        where object_id = :package_id
    
      </querytext>
</fullquery>
 
<partialquery name="dir_alpha_nav_bar.table_and_group_1">      
      <querytext>
          dir_all_users m where 1=1
      </querytext>
</partialquery>
 
<partialquery name="dir_alpha_nav_bar.table_and_group_2">      
      <querytext>
          dir_group_members m where group_id = :group_id
      </querytext>
</partialquery>
 
</queryset>
