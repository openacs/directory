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
         $where_clause
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
 
<partialquery name="order_by_name">      
      <querytext>
        order by lower(last_name)
      </querytext>
</partialquery>

<partialquery name="order_by_email">      
      <querytext>
        order by email
      </querytext>
</partialquery>

<partialquery name="order_by_name-">      
      <querytext>
        order by lower(last_name) desc
      </querytext>
</partialquery>
 
<partialquery name="order_by_email-">      
      <querytext>
        order by email desc
      </querytext>
</partialquery>

<partialquery name="where_1">      
      <querytext>
         and (lower(first_names) like '%' || lower(:search) || '%'
              or lower(last_name) like '%' || lower(:search) || '%'
              or email like '%' || lower(:search) || '%')
      </querytext>
</partialquery>
 
<partialquery name="where_2">      
      <querytext>
         and upper(last_name) like :letter || '%'
      </querytext>
</partialquery>
 
<fullquery name="get_all_users">      
      <querytext>
         select m.* from $table_and_group
           $where_clause
           $order_clause
      </querytext>
</fullquery>
 
</queryset>
