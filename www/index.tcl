ad_page_contract {

    Browse all users.
    
    @author mikeb@arsdigita.com
    @cvs-id $Id$
    @param order_by Column to order the results by
    @param num_rows Number of users to display at a time
    @param start_row Row number to start at
    @param search Text to search for in the users name or email address
    @param letter Letter to use when browsing by last name

} {
    {order_by:optional "name"}
    {start_row:optional,naturalnum 1}
    {num_rows:optional,naturalnum 20}
    {letter:optional ""}
    {search:optional ""}
    {all_users:optional,boolean "f"}
} -properties {
    page_title:onevalue
    all_user_data:multirow
    context_bar_args:onevalue
    system_name:onevalue
    package_url:onevalue
    header_link_vars:onevalue
    start_row:onevalue
    last_row:onevalue
    option_list:onevalue
    total_users:onevalue
}

set valid_numrows [list 10 20 50 0]
if { [lsearch $valid_numrows $num_rows] < 0 } {
    set num_rows 20
}
set numrow_vars [export_ns_set_vars url [list num_rows]]
set search_vars [export_ns_set_vars form [list search start_row letter]]
set browse_vars [export_ns_set_vars url [list search start_row]]

set page_width      [ad_parameter PageWidth]
set navbar_list     [dir_navbar_list]
set master_template [ad_parameter MasterTemplate]

# if they want to see all users, select from dir_all_users
# and use a dummy where clause
if {$all_users == "t"} {
    set table_and_group [db_map table_and_group_1]
    set group_name "this site"
    set group_id -1
    set page_title "Browse users"
} else {
    set table_and_group [db_map table_and_group_2]
    foreach {group_id group_name} [dir_app_group_info] {}
    set page_title "Browse members"
}


set order_clause ""
if {$order_by == "name"} {
    set order_clause " order by lower(last_name)"
} elseif {$order_by == "email"} {
    set order_clause " order by lower(email)"
} elseif {$order_by == "name-"} {
    set order_clause " order by lower(last_name) desc"
} elseif {$order_by == "email-"} {
    set order_clause " order by lower(email) desc"
}

if {![empty_string_p $search]} {
    set where_clause "and (lower(first_names) like '%' || lower(:search) || '%'
                        or lower(last_name) like '%' || lower(:search) || '%'
                        or lower(email) like '%' || lower(:search) || '%')"
    set where_text " with something matching &quot;$search&quot;"
    set alpha_nav_bar ""
} elseif {![empty_string_p $letter] && $letter != "all"} {
    set where_clause "and upper(last_name) like :letter || '%'"
    set where_text " with a last name starting with $letter"
    set alpha_nav_bar [dir_alpha_nav_bar -group_id $group_id -all_users $all_users $letter start_row]
} else {
    set where_clause ""
    set where_text ""
    set alpha_nav_bar [dir_alpha_nav_bar -group_id $group_id -all_users $all_users $letter start_row]
}

set total_users [db_string total_users_1 "
   select count(1)
     from $table_and_group"]

if {[empty_string_p $where_clause]} {
    set queried_users $total_users
} else {
    set queried_users [db_string total_users_1 "
   select count(1)
     from $table_and_group
   $where_clause"]

}

set header_link_vars "[export_ns_set_vars url {order_by}]"

set name_header [ad_decode $order_by "name" "<a href=index?order_by=name-&$header_link_vars>Name:</a>&nbsp;^" "name-" "<a href=index?order_by=name&$header_link_vars>Name:</a>&nbsp;v" "<a href=index?order_by=name&$header_link_vars>Name:</a>"]
set email_header [ad_decode $order_by "email" "<a href=index?order_by=email-&$header_link_vars>E-mail Address:</a>&nbsp;^" "email-" "<a href=index?order_by=email&$header_link_vars>E-mail Address:</a>&nbsp;v" "<a href=index?order_by=email&$header_link_vars>E-mail Address:</a>"]


# this query is really ugly (3 nested selects!) but it's the only way to get a
# "between" to work correctly on the rownum of an ordered set
# if anyone knows a better way, I'd love to hear it - mikeb
set sql_query "select m.*
                 from $table_and_group
                $where_clause
                $order_clause"

if {$num_rows != "0"} {
    set end_row [expr $start_row + $num_rows - 1]
    set sql_query "
                  select * from (
                    select first_names, last_name, email, user_id, rownum as my_rownum from (
                     $sql_query
                    )
                   ) where my_rownum between :start_row and :end_row"
}

db_multirow all_user_data get_all_users $sql_query

set rowcount [template::multirow size all_user_data]

set last_row [expr $start_row + $rowcount - 1]

set row_range_html ""
if {$rowcount < $queried_users} {
    set row_range_html "<tr>\n<td align=left>"
    if {$start_row > 1} {
        if {[expr $start_row - $num_rows] < 1} {
            append row_range_html "<a href=index?start_row=1&[export_ns_set_vars url start_row]>&lt; Back</a>\n"
        } else {
            append row_range_html "<a href=index?start_row=[expr $start_row - $num_rows]&[export_ns_set_vars url start_row]>&lt; Back</a>\n"
        }
    } else {
        append row_range_html "&nbsp;\n"
    }
    
    append row_range_html "</td>\n"
    append row_range_html "<td align=right>"

    if {[expr $start_row + $num_rows - 1] < $queried_users} {
        append row_range_html "<a href=index?start_row=[expr $start_row + $num_rows]&[export_ns_set_vars url start_row]>Forward &gt;</a>\n"
    } else {
        append row_range_html "&nbsp;\n"
    }

    append row_range_html "</td>\n"
}
