<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="get_all_n_users">      
      <querytext>
         select m.* from $table_and_group
         $where_clause
         $order_clause
         offset [expr $start_row - 1] limit $num_rows
      </querytext>
</fullquery>
 
</queryset>
