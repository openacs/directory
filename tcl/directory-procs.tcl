ad_library {

    Definitions for the User Directory module

    @author Mike Bonnet (mikeb@arsdigita.com)
    @cvs-id $Id$

}

ad_proc dir_navbar_list {
    -top:boolean
    {navbar_list_list ""}
} {
    set subsite_home [lindex [site_node::get_url_from_object_id -object_id [site_node::closest_ancestor_package -include_self -package_key "acs-subsite"]] 0]

    set package_home [ad_conn package_url]

    set default_elements [list \
                            [list $subsite_home Home]\
                            [list $package_home "User Directory"]]

    if { $top_p } {
        set default_elements [lrange $default_elements 0 [expr [llength $default_elements] - 2]]
    }

    set navbar_list_list [concat $default_elements $navbar_list_list]

    set navbar_list {}

    foreach pair $navbar_list_list {
        lappend navbar_list "<a href=[lindex $pair 0]>[lindex $pair 1]</a>"
    }

    return $navbar_list
}

# code borrowed from intranet module
ad_proc dir_all_letters {} {returns a list of all A-Z letters in uppercase} {
    return [list A B C D E F G H I J K L M N O P Q R S T U V W X Y Z] 
}

ad_proc dir_alpha_nav_bar {
    -group_id
    -all_users
    letter 
    {excluded_vars ""}
} {
    Returns an A-Z bar with greyed out letters not
    in initial_list and bolds "letter".

    Includes all existing url vars except those in
    the "excluded_vars" list.
} {
    if {$all_users == "t"} {
        set table_and_group [db_map table_and_group_1]
    } else {
        set table_and_group [db_map table_and_group_2]
        set group_id [lindex [dir_app_group_info] 0]
    }

    set url "[ad_conn url]?"
    set exclude_list [list "letter"]
    foreach v $excluded_vars { 
	lappend exclude_list $v
    }

    set query_args [export_ns_set_vars url $exclude_list]
    if { ![empty_string_p $query_args] } {
	append url "$query_args&"
    }

    set initial_list [db_list initial_list "
	select distinct upper(substr(last_name,1,1)) 
          from $table_and_group"]

    set html_list [list]
    foreach l [dir_all_letters] {
	if { [lsearch -exact $initial_list $l] == -1 } {
	    # This means no user has this initial
	    lappend html_list "<font color=gray>$l</font>"
	} elseif { [string compare $l $letter] == 0 } {
	    lappend html_list "<b>$l</b>"
	} else {
	    lappend html_list "<a href=${url}letter=$l>$l</a>"
	}
    }
    if { [empty_string_p $letter] || [string compare $letter "all"] == 0 } {
	lappend html_list "<b>All</b>"
    } else {
	lappend html_list "<a href=${url}letter=all>All</a>"
    }
    return [join $html_list " | "]
}

ad_proc dir_app_group_info {} {

    Return a list containing the group_id (lindex 0) and group_name (lindex 1) of the application group associated with the subsite that the current directory package is mounted under.  
    The directory package does not need to be mounted directly under the subsite; it will find the closest instance of subsite than is an ancestor of the package.

} {
    
    set package_id [ad_conn package_id]
    db_1row n_id {
        select node_id from site_nodes
        where object_id = :package_id
    }
    
    # find the closest subsite to the current package on the site_nodes tree
    # the inner query is guaranteed to always return at least 1 row, 
    # because the Main Site subsite is mounted at /
    db_1row subsite_p_1 {
        select * from (
          select object_id as subsite_id
            from site_nodes n
           where (select package_key from apm_packages p where p.package_id = n.object_id) = 'acs-subsite' 
         connect by node_id = prior parent_id 
           start with node_id = :node_id 
           order by level
        ) where rownum = 1
    }
    
    db_1row g_i {
      select g.group_id, g.group_name
        from groups g, application_groups a
       where a.package_id = :subsite_id
         and a.group_id = g.group_id
    }

    return [list $group_id $group_name]
}

ad_proc dir_subsite_info {} {

    Return a list containing the subsite_id (lindex 0) and subsite_name (lindex 1) of the subsite that the current directory package is mounted under.  
    The directory package does not need to be mounted directly under the subsite; it will find the closest instance of subsite than is an ancestor of the package.

} {
    
    set package_id [ad_conn package_id]
    db_1row n_id {
        select node_id from site_nodes
        where object_id = :package_id
    }
    
    # find the closest subsite to the current package on the site_nodes tree
    # the inner query is guaranteed to always return at least 1 row, 
    # because the Main Site subsite is mounted at /
    db_1row subsite_p_2 {
        select * from (
          select object_id as subsite_id, acs_object.name(object_id) as subsite_name
            from site_nodes n
           where (select package_key from apm_packages p where p.package_id = n.object_id) = 'acs-subsite' 
         connect by node_id = prior parent_id 
           start with node_id = :node_id 
           order by level
        ) where rownum = 1
    }
    
    return [list $subsite_id $subsite_name]
}

set mods_file [ns_info tcllib]/directory-mods.tcl
    
if [file exists $mods_file] {
    source $mods_file
}
