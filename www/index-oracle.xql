<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="get_all_n_users">      
      <querytext>
         select * from (
           select first_names, last_name, email, user_id, rownum as my_rownum from (
              select m.* from $table_and_group
              $where_clause
              $order_clause
           )
         ) where my_rownum between :start_row and [expr $start_row + $num_rows - 1]
      </querytext>
</fullquery>


</queryset>
