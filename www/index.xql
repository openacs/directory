<?xml version="1.0"?>
<queryset>

<fullquery name="total_users_1">      
      <querytext>
      
   select count(1)
     from $table_and_group
      </querytext>
</fullquery>

 
<fullquery name="total_users_2">      
      <querytext>
      
   select count(1)
     from $table_and_group
      </querytext>
</fullquery>
 
<partialquery name="table_and_group_1">      
      <querytext>
          dir_all_users m where 1=1
      </querytext>
</partialquery>
 
<partialquery name="table_and_group_2">      
      <querytext>
          dir_group_members m where group_id = :group_id
      </querytext>
</partialquery>
 
</queryset>
